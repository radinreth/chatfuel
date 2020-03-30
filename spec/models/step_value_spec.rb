# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  step_id           :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_step_id            (step_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (step_id => steps.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
require 'rails_helper'

RSpec.describe StepValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
