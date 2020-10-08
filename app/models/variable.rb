# == Schema Information
#
# Table name: variables
#
#  id                  :bigint(8)        not null, primary key
#  is_location         :boolean
#  is_most_request     :boolean          default(FALSE)
#  is_service_accessed :boolean          default(FALSE)
#  is_ticket_tracking  :boolean          default(FALSE)
#  is_user_visit       :boolean          default(FALSE)
#  name                :string
#  report_enabled      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Variable < ApplicationRecord
  default_scope { order(created_at: :desc) }

  # associations
  has_many :step_values, dependent: :destroy
  has_many :role_variables, dependent: :destroy
  has_many :roles, through: :role_variables
  has_many :values, class_name: "VariableValue",
                    dependent: :destroy,
                    autosave: true

  # callbacks
  before_save :ensure_only_one_is_most_request
  before_save :ensure_only_one_is_user_visit
  before_save :ensure_only_one_is_service_accessed
  before_save :ensure_only_one_is_ticket_tracking

  # validations
  validate :only_one_report_column
  validate :validate_unique_raw_value
  validates :name, presence: { message: I18n.t("variable.presence") }, uniqueness: true
  validates :name, format: { with: /\A[\w|\s|-]+\z/, message: I18n.t("variable.invalid_name") }, if: -> { name.present? }

  accepts_nested_attributes_for :values, allow_destroy: true, reject_if: :rejected_values

  delegate :site_setting, to: :site, prefix: false, allow_nil: true

  def to_partial_path
    "dictionaries/dictionary"
  end

  def feedback_message?
    report_enabled
  end

  def ensure_value value = nil
    if value.present? && !value.null_value?
      return values.find_or_create_by(raw_value: value)
    end
  end

  def self.filter(params)
    scope = all
    scope = scope.where("name LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
    scope
  end

  private
    def validate_unique_raw_value
      validate_uniqueness_of_in_memory(values, %i[raw_value], I18n.t("variable.already_taken"))
    end

    def ensure_only_one_is_most_request
      return unless is_most_request_changed?
      sibling.update_all(is_most_request: false)
    end

    def ensure_only_one_is_user_visit
      return unless is_user_visit_changed?
      sibling.update_all(is_user_visit: false)
    end

    def ensure_only_one_is_service_accessed
      return unless is_service_accessed_changed?
      sibling.update_all(is_service_accessed: false)
    end

    def ensure_only_one_is_ticket_tracking
      return unless is_ticket_tracking_changed?
      sibling.update_all(is_ticket_tracking: false)
    end

    def only_one_report_column
      errors.add(:report_enabled, I18n.t("variable.only_one_report_col")) if report_enabled? && report_already_set?
    end

    def report_already_set?
      sibling.exists?(report_enabled: true)
    end

    def sibling
      Variable.where.not(id: self)
    end

    def rejected_values(attributes)
      attributes["raw_value"].blank?
    end
end
