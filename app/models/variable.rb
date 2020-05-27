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
  # associations
  has_many :role_variables, dependent: :destroy
  has_many :roles, through: :role_variables
  has_many :values, class_name: "VariableValue",
                    dependent: :destroy,
                    autosave: true

  # validations
  validate :only_one_report_column
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :name,  allow_blank: true,
                    format: { with: /\A\w+\z/,
                              message: "only allows numbers or letters" }

  private
    def only_one_report_column
      errors.add(:report_enabled, "Must be enable only one") if report_enabled == true && Variable.exists?(report_enabled: true)
    end
end
