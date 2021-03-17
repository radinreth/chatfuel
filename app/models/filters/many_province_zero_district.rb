module Filters
  class ManyProvinceZeroDistrict < ProvinceDistrict
    def display_name
<<<<<<< HEAD
      I18n.t(:selected_provinces, count: provinces.count)
    end
    
    def described_name
      provinces.map {|p| p.send(name_i18n)}.to_sentence
=======
      "#{provinces.count} provinces"
    end
    
    def described_name
      provinces.map(&:name_en).to_sentence
>>>>>>> multi provinces
    end
  end
end
