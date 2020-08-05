# == Schema Information
#
# Table name: variable_values
#
#  id                :bigint(8)        not null, primary key
#  mapping_value     :string           default("")
#  raw_value         :string           not null
#  status            :string           default("1")
#  step_values_count :integer(4)       default("0")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  variable_id       :bigint(8)        not null
#
# Indexes
#
#  index_variable_values_on_variable_id  (variable_id)
#
# Foreign Keys
#
#  fk_rails_...  (variable_id => variables.id)
#
require 'rails_helper'

RSpec.describe VariableValue, type: :model do
  describe 'before_destroy' do
    let(:step_value)      { create(:step_value) }
    let(:variable_value)  { step_value.variable_value }
    let(:variable_value2) { create(:variable_value) }

    it { expect(variable_value.destroy).to be_falsey }
    it { expect(variable_value2.destroy).to be_truthy }
  end
end
