require "rails_helper"

RSpec.describe Filters::DistrictFilter do
  context "with one district_code" do
    it "#name" do
      district = described_class.new ["0212"]

      expect(district.name).to eq "Kamrieng"
    end
  end

  context "with many district_codes" do
    it "#name" do
      district = described_class.new ["0212", "0213"]

      expect(district.name).to eq "2 districts"
    end
  end
end
