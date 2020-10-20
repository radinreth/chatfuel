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

  describe "validation" do
    describe "mark_as" do
      context "when blank" do
        let(:variable) { build(:variable, mark_as: "") }

        it { expect(variable).to be_valid }
      end

      context "with whitelist" do
        let(:variable) { build(:variable, mark_as: "feedback") }

        MarkAsConcern::WHITELIST_MARK_AS.each do |mark_as|
          it "valid" do
            variable.mark_as = mark_as

            expect(variable).to be_valid
          end
        end
      end

      context "without whitelist" do
        let(:variable) { build(:variable, mark_as: "test") }

        it { expect(variable).to be_invalid }
      end
    end
  end
end
