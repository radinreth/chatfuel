# == Schema Information
#
# Table name: variable_values
#
#  id            :bigint(8)        not null, primary key
#  mapping_value :string           default("")
#  raw_value     :string           not null
#  status        :integer(4)       default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  variable_id   :bigint(8)        not null
#
# Indexes
#
#  index_variable_values_on_variable_id  (variable_id)
#
# Foreign Keys
#
#  fk_rails_...  (variable_id => variables.id)
#
class VariableValue < ApplicationRecord
  enum status: %i[normal satisfied disatisfied]

  # associations
  belongs_to :variable
  has_many :step_values
  has_many :steps, through: :step_values
  has_many :ratings, dependent: :destroy
  has_many :feedbacks, through: :ratings

  # validations
  validates :raw_value, presence: true, uniqueness: { scope: :variable_id }
  default_scope -> { order(:raw_value) }

  def display_value
    mapping_value.presence || raw_value
  end

  delegate :name, to: :variable, prefix: true
end
