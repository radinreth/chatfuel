# == Schema Information
#
# Table name: variables
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  report_enabled :boolean          default("false")
#  status         :integer(4)       default("0")
#  text           :string
#  type           :string           not null
#  value          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_variables_on_type_and_name_and_value  (type,name,value) UNIQUE
#
class Variable < ApplicationRecord
  enum status: %i[normal satisfied disatisfied]

  # associations
  has_many :ratings, dependent: :destroy
  has_many :feedbacks, through: :ratings

  has_many :role_variables
  has_many :roles, through: :role_variables

  # validations
  validates :type, presence: true
  validates :name, presence: true
  validates :value, uniqueness: { scope: :name }
  validates :name,  allow_blank: true,
                    format: { with: /\A\w+\z/,
                              message: "only allows numbers or letters" }
end
