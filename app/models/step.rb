# == Schema Information
#
# Table name: steps
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint(8)        not null
#
# Indexes
#
#  index_steps_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
class Step < ApplicationRecord
  belongs_to :message

  # associations
  has_one :step_value, dependent: :destroy
  has_one :site, through: :step_value
  has_one :value, through: :step_value,
                  class_name: "VariableValue",
                  source: :variable_value
  has_one :track, dependent: :destroy

  def self.accessed
    owso_options = Variable.find_by(name: "owso_options")
    joins(:value).where("variable_values.id in (?)", owso_options.values.ids)
  end

  def value
    super || track
  end
end
