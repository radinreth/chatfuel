module Filters
  class OneProvinceZeroDistrict < ProvinceDistrict
    def display_name
      province.name_en
    end
    
    def described_name;end
  end
end
