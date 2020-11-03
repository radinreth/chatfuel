require "rails_helper"

RSpec.describe LocationFilter do
  context "with province, one district" do
    let(:province_filter) { Filters::ProvinceFilter.new("02") }
    let(:district_filter) { Filters::DistrictFilter.new(["0212"]) }

    it "#name" do
      location_filter = LocationFilter.new(province_filter, district_filter)

      expect(location_filter.name).to eq("Kamrieng in Battambang")
    end
  end

  context "with province, more than one districts" do
    let(:province_filter) { Filters::ProvinceFilter.new("02") }
    let(:district_filter) { Filters::DistrictFilter.new(["0212", "0213"]) }

    it "#name" do
      location_filter = LocationFilter.new(province_filter, district_filter)

      expect(location_filter.name).to eq("2 districts in Battambang")
    end
  end

  context "with province, no district" do
    let(:province_filter) { Filters::ProvinceFilter.new("02") }

    it "#name" do
      location_filter = LocationFilter.new(province_filter, nil)

      expect(location_filter.name).to eq("Battambang")
    end
  end

  context "with no province, no district" do
    it "#name" do
      location_filter = LocationFilter.new(nil, nil)

      expect(location_filter.name).to eq("All")
    end
  end
end
