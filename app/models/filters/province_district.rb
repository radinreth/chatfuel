module Filters
  class ProvinceDistrict
    attr_reader :provinces, :districts

    def initialize(provinces, districts)
      @provinces = provinces
      @districts = districts
    end

    private

    def province
      provinces.first
    end

    def district
      districts.first
    end
  end
end
