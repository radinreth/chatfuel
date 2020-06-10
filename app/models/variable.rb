# == Schema Information
#
# Table name: variables
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  report_enabled :boolean          default("false")
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Variable < ApplicationRecord
  default_scope { order(name: :asc) }
  scope :except_done, -> { where.not(name: "done") }

  # associations
  has_many :role_variables, dependent: :destroy
  has_many :roles, through: :role_variables
  has_many :values, class_name: "VariableValue",
                    dependent: :destroy,
                    autosave: true

  accepts_nested_attributes_for :values

  # validations
  validate :only_one_report_column
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :name,  allow_blank: true,
                    format: { with: /\A\w+\z/,
                              message: I18n.t("variable.invalid_name") }

  def to_partial_path
    "dictionaries/dictionary"
  end

  private
    def only_one_report_column
      errors.add(:report_enabled, I18n.t("variable.only_one_report_col")) if report_enabled? && Variable.exists?(report_enabled: true)
    end
end
