module Filters
  class OneProvinceOneDistrict < ProvinceDistrict
    def display_name
<<<<<<< HEAD
      district.send(name_i18n)
=======
      district.name_en
    end
    
    def described_name
      display_name
>>>>>>> multi provinces
    end
  end
end
