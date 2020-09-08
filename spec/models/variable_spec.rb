# == Schema Information
#
# Table name: variables
#
#  id                  :bigint(8)        not null, primary key
#  is_location         :boolean
#  is_most_request     :boolean          default("false")
#  is_service_accessed :boolean          default("false")
#  is_ticket_tracking  :boolean          default("false")
#  is_user_visit       :boolean          default("false")
#  marks_as            :string           is an Array
#  name                :string
#  report_enabled      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_variables_on_marks_as  (marks_as) USING gin
#
require "rails_helper"

RSpec.describe Variable, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe '.validate_unique_raw_value' do
    context 'valid' do
      let(:variable) { Variable.new({
          name: 'certify_document',
          values_attributes: [
            { raw_value: 'document 1' },
            { raw_value: 'document 2'}
          ]
        })
      }

      it { expect(variable.valid?).to be_truthy }
    end

    context 'invalid' do
      let(:variable) { Variable.new({
          name: 'certify_document',
          values_attributes: [
            { raw_value: 'document 1'},
            { raw_value: 'document 1'},
            { raw_value: 'document 2'}
          ]
        })
      }

      before {
        variable.valid?
      }

      it { expect(variable.valid?).to be_falsey }
      it { expect(variable.errors).to include :variablevalues }
      it { expect(variable.errors[:variablevalues]).to eq(["has already been taken"]) }
    end

    context 'update with existing' do
      let(:variable) { Variable.create({
          name: 'certify_document',
          values_attributes: [
            { raw_value: 'document 1' },
            { raw_value: 'document 2'}
          ]
        })
      }

      before {
        variable.values.new({ raw_value: 'document 1'})
        variable.save
      }

      it { expect(variable.valid?).to be_falsey }
      it { expect(variable.errors).to include :variablevalues }
      it { expect(variable.errors[:variablevalues]).to eq(["has already been taken"]) }
    end
  end

  describe '#ensure_value' do
    let!(:variable) { create(:variable) }

    context 'create a variable value when a value is not null' do
      it { expect { variable.ensure_value('foo')}.to change{VariableValue.count}.by(1) }
    end

    context 'ignore create a variable value when a value is null' do
      it { expect { variable.ensure_value('null')}.to change{VariableValue.count}.by(0) }
    end
  end
end
