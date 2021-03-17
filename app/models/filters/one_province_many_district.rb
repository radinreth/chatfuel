module Filters
  class OneProvinceManyDistrict < ProvinceDistrict
    def display_name
      "#{districts.count} districts"
    end
    
    def described_name
      districts.map(&:name_en).to_sentence
    end
  end
end
