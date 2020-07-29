# == Schema Information
#
# Table name: steps
#
#  id :bigint(8)        not null, primary key
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
    joins(:value).where("variable_values.id in (?)", owso_options&.values&.ids)
  end
end
