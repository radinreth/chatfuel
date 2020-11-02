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
#  mark_as             :string           default("")
#  name                :string
#  report_enabled      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_variables_on_mark_as  (mark_as)
#

require_relative "validators/mark_as_validator"

class Variable < ApplicationRecord
  FEEDBACK = 'feedback'
  include MarkAsConcern

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
  validate do |variable|
    Validators::MarkAsValidator.new(variable).validate
  end

  validate :validate_unique_raw_value
  validates :name, presence: { message: I18n.t("variable.presence") }, uniqueness: true
  validates :name, format: { with: /\A[\w|\s|-]+\z/, message: I18n.t("variable.invalid_name") }, if: -> { name.present? }
  validates :mark_as, inclusion: { allow_blank: true,
                                  in: MarkAsConcern::WHITELIST_MARK_AS,
                                  message: I18n.t("variable.invalid_mark_as") }

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

  def criteria?
    values.any? { |value| value.is_criteria? }
  end

  private
    def validate_unique_raw_value
      validate_uniqueness_of_in_memory(values, %i[raw_value], I18n.t("variable.already_taken"))
    end

    def rejected_values(attributes)
      attributes["raw_value"].blank?
    end
end
