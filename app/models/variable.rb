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
#  report_enabled      :boolean          default(FALSE)
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
  # scopes
  scope :most_request, -> { find_by(is_most_request: true) }

  # validations
  validate :validate_all_marked_as_items_in_whitelist
  validate :validate_uniq_marked_as_items
  validate :validate_one_report
  validate :validate_one_most_request
  validate :validate_one_user_visit
  validate :validate_one_ticket_tracking
  validate :validate_one_service_accessed
  validate :validate_one_location

  validate :validate_unique_raw_value
  validates :name, presence: { message: I18n.t("variable.presence") }, uniqueness: true
  validates :name, format: { with: /\A[\w|\s|-]+\z/, message: I18n.t("variable.invalid_name") }, if: -> { name.present? }

  accepts_nested_attributes_for :values, allow_destroy: true, reject_if: :rejected_values

  delegate :site_setting, to: :site, prefix: false, allow_nil: true

  def to_partial_path
    "dictionaries/dictionary"
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

  def transform_key_result(value_id, count)
    value = values.find(value_id)

    { key: value.mapping_value, value: count }
  end

  def agg_values_count(options)
    scope = StepValue.filter(step_values, options)
    scope = scope.order("count_all DESC")
    scope = scope.group("variable_value_id")
    scope.count
  end

  private

    def validate_all_marked_as_items_in_whitelist
      return if all_marked_as_items_in_whitelist?

      errors.add(:marks_as, "invalid marked_as item")
    end

    def all_marked_as_items_in_whitelist?
      self.marks_as.all? { |item| MarksAsHelper::WHITELIST_MARKS_AS.include?(item) }
    end

    def validate_uniq_marked_as_items
      return if uniq_marked_as_items?

      errors.add(:marks_as, I18n.t("variable.already_added"))
    end

    def uniq_marked_as_items?
      marks_as.uniq.length == marks_as.length
    end

    def validate_unique_raw_value
      validate_uniqueness_of_in_memory(values, %i[raw_value], I18n.t("variable.already_taken"))
    end

    def validate_one_most_request
      return unless sibling.most_request

      errors.add(:most_request, I18n.t("variable.already_taken")) if most_request?
    end

    def validate_one_user_visit
      return unless sibling.user_visit

      errors.add(:user_visit, I18n.t("variable.already_taken")) if user_visit?
    end

    def validate_one_ticket_tracking
      return unless sibling.ticket_tracking

      errors.add(:ticket_tracking, I18n.t("variable.already_taken")) if ticket_tracking?
    end

    def validate_one_service_accessed
      return unless sibling.service_accessed

      errors.add(:service_accessed, I18n.t("variable.already_taken")) if service_accessed?
    end

    def validate_one_report
      return unless sibling.report

      errors.add(:report, I18n.t("variable.already_taken")) if report?
    end

    def validate_one_location
      return unless sibling.location

      errors.add(:location, I18n.t("variable.already_taken")) if location?
    end

    def sibling
      Variable.unscoped.where.not(id: self)
    end

    def rejected_values(attributes)
      attributes["raw_value"].blank?
    end
end
