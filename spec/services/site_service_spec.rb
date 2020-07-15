require "rails_helper"

RSpec.describe SiteService do
  describe '#provinces' do
    before {
      create(:site, name: 'site_a', code: '0102')
      create(:site, name: 'site_b', code: '0103')
      create(:site, name: 'site_c', code: '0202')
      create(:site, name: 'site_d', code: '0203')
    }

    context 'no params' do
      let(:provinces) { SiteService.new.provinces }

      it { expect(provinces.length).to eq(2) }
      it { expect(provinces.first['sites_count']).to eq(2) }
      it { expect(provinces.first['sites'].length).to eq(2) }
    end

    context 'params keyword is code 0202' do
      let(:provinces) { SiteService.new(keyword: '0202').provinces }

      it { expect(provinces.length).to eq(1) }
      it { expect(provinces.first['sites_count']).to eq(1) }
      it { expect(provinces.first['sites'].length).to eq(1) }
    end
  end
end
