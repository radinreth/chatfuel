module Filters
  class OneProvinceZeroDistrict < ProvinceDistrict
    def display_name
      province.send(name_i18n)
    end
    
    def described_name;end
  end
end
