module Filters
  class ManyProvinceZeroDistrict < ProvinceDistrict
    def display_name
      "#{provinces.count} provinces"
    end
    
    def described_name
      provinces.map(&:name_en).to_sentence
    end
  end
end
