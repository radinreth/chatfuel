module Filters
  class OneProvinceOneDistrict < ProvinceDistrict
    def display_name
      district.name_en
    end
    
    def described_name;end
  end
end
