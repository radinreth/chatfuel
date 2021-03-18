module Filters
  class OneProvinceOneDistrict < ProvinceDistrict
    def display_name
      district.send(name_i18n)
    end
    
    def described_name;end
  end
end
