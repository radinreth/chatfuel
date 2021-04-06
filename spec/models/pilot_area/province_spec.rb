require 'rails_helper'

RSpec.describe PilotArea::Province do
  subject { PilotArea::Province }
  
  pilot_provinces = ENV['PILOT_PROVINCE_CODES'].to_s.split(',')

  it ".all" do
    expect(subject.all).to eq(pilot_provinces)
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
