# == Schema Information
#
# Table name: variables
#
#  id                  :bigint(8)        not null, primary key
#  is_location         :boolean
#  is_most_request     :boolean          default("false")
#  is_service_accessed :boolean          default("false")
#  is_ticket_tracking  :boolean          default("false")
#  is_user_visit       :boolean          default("false")
#  marks_as            :string           default("{}"), is an Array
#  name                :string
#  report_enabled      :boolean          default("false")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_variables_on_marks_as  (marks_as) USING gin
#
class Variable < ApplicationRecord
  include MarksAsHelper

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
  validate :whitelist_marks_as
  validate :uniq_marks_as
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
    mark_as_report?
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

    def whitelist_marks_as
      return if whitelist_marks_as?

      errors.add(:marks_as, :invalid, message: "invalid marks_as")
      throw :abort
    end

    def whitelist_marks_as?
      self.marks_as.all? { |item| MarksAsHelper::WHITELIST_MARKS_AS.include?(item) }
    end

    def uniq_marks_as
      if duplicate_marks_as?
        errors.add(:marks_as, :not_uniq, message: "cannot add duplicate value")
        throw :abort
      end
    end

    def duplicate_marks_as?
      marks_as.detect { |e| marks_as.count(e) > 1 }
    end

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
      return unless sibling.mark_as_report

      errors.add(:marks_as, I18n.t("variable.only_one_report_col")) if mark_as_report?
    end

    def sibling
      Variable.where.not(id: self)
    end

    def rejected_values(attributes)
      attributes["raw_value"].blank?
    end
end
