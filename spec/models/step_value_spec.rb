# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  site_id           :bigint(8)
#  step_id           :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_site_id            (site_id)
#  index_step_values_on_step_id            (step_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (step_id => steps.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
require 'rails_helper'

RSpec.describe StepValue, type: :model do
  describe '.after_create, set_message_province_id' do
    let(:step_value) { build(:step_value) }

    before {
      step_value.variable_value.mapping_value = '01'
      variable = step_value.variable_value.variable
      variable.is_location = true
      step_value.save
    }

    it { expect(step_value.step.message.province_id).to eq('01') }
  end
end
