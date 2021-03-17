module Filters
  class OneProvinceZeroDistrict < ProvinceDistrict
    def display_name
<<<<<<< HEAD
      province.send(name_i18n)
=======
      province.name_en
    end
    
    def described_name
      province.name_en
>>>>>>> multi provinces
    end
  end
end
