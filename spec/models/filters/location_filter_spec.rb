require "rails_helper"

RSpec.describe Filters::LocationFilter do
  describe "#display_name" do
    context "with no province, no district" do
      before(:each) do
        @location_filter = Filters::LocationFilter.new(nil, nil)
      end

      it { expect(@location_filter.display_name).to eq("All") }
    end

    context "with province" do
      let(:province) { Pumi::Province.find_by_id("02") }
      
      context "no district" do
        before(:each) do
          @location_filter = Filters::LocationFilter.new(province, nil)
        end

        it { expect(@location_filter.display_name).to eq("Battambang Province") }
      end

      context "one district" do
        let(:districts) { [Pumi::District.find_by_id("0212")] }

        before(:each) do
          @location_filter = Filters::LocationFilter.new(province, districts)
        end

        it { expect(@location_filter.display_name).to eq("Kamrieng") }
      end

      context "more than one districts" do
        let(:district_1) { [Pumi::District.find_by_id("0212")] }
        let(:district_2) { [Pumi::District.find_by_id("0212")] }
        let(:districts) { [district_1, district_2] }

        before(:each) do
          @location_filter = Filters::LocationFilter.new(province, districts)
        end

        it { expect(@location_filter.display_name).to eq("2 districts selected") }
      end
    end 
  end
end
