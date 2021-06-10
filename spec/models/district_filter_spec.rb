require 'rails_helper'

RSpec.describe DistrictFilter do
  describe '.fetch' do
    let!(:bat) { create(:session, district_id: '0100') }
    let!(:bmc) { create(:session, district_id: '0200') }
    let!(:chh) { create(:session, district_id: '0400') }

    before do
      allow(DistrictFilter).to receive(:pilot_codes).and_return(['0100', '0200'])
    end

    context "with OTHER" do
      it 'fetches district codes beside pilot areas' do
        filter = described_class.fetch '0000'

        expect(filter).to match_array ['0400']
      end
    end

    context "without OTHER" do
      it 'fetches one district codes in pilot areas' do
        filter = described_class.fetch '0100'

        expect(filter).to match_array ['0100']
      end

      it 'fetches more district codes in pilot areas' do
        filter = described_class.fetch '0100', '0200', '0400'

        expect(filter).to match_array ['0100', '0200']
      end
    end
  end
end
