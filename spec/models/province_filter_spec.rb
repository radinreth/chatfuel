require 'rails_helper'

RSpec.describe ProvinceFilter do
  describe '.fetch' do
    let!(:bat) { create(:session, province_id: '01') }
    let!(:bmc) { create(:session, province_id: '02') }
    let!(:chh) { create(:session, province_id: '04') }

    before do
      allow(ProvinceFilter).to receive(:pilot_codes).and_return(['01', '02'])
    end

    context "with OTHER" do
      it 'fetches province codes beside pilot areas' do
        filter = described_class.fetch '00'

        expect(filter).to match_array ['04']
      end
    end

    context "without OTHER" do
      it 'fetches one province codes in pilot areas' do
        filter = described_class.fetch '01'

        expect(filter).to match_array ['01']
      end

      it 'fetches more province codes in pilot areas' do
        filter = described_class.fetch '01', '02', '04'

        expect(filter).to match_array ['01', '02']
      end
    end
  end
end
