require 'rails_helper'

RSpec.describe PilotArea::Province do
  subject { PilotArea::Province }
  
  pilot_provinces = ENV['PILOT_PROVINCE_CODES'].to_s.split(',')

  it ".all" do
    expect(subject.all).to eq(pilot_provinces)
  end

  context "when pumi" do
    before do
      @pumi = subject.new("01").to_pumi
    end

    it "returns instance of Pumi province" do
      expect(@pumi.pumi_province).to be_kind_of(Pumi::Province)
    end

    it "returns instance of Pumi districts" do
      expect(@pumi.districts).to all(be_an(Pumi::District))
    end
  end

  pilot_provinces.each do |province_code|
    context "with #{province_code}" do
      let(:province) { subject.new(province_code) }

      it '#districts' do
        district_codes = ENV["PILOT_DISTRICT_CODES_FOR_#{province_code}"].to_s.split(',')
        expect(province.districts).to eq(district_codes)
      end
    end
  end

  it "raise error for non-piloted province code" do
    expect {
      subject.new("99").districts
    }.to raise_error
  end
end
