require 'rails_helper'

RSpec.describe Filters::PumiFilter do
  subject { Filters::PumiFilter }

  before do
    ENV['PILOT_PROVINCE_CODES'] = '01'
    ENV['PILOT_DISTRICT_CODES_FOR_01'] = '0102,0103'
  end

  it '.pilot_province_codes' do
    expect(subject.pilot_province_codes).to match_array(['01'])
  end

  it '.pilot_district_codes' do
    expect(subject.pilot_district_codes).to match_array(['0102', '0103'])
  end
end
