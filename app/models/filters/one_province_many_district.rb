module Filters
  class OneProvinceManyDistrict < ProvinceDistrict
    def display_name
<<<<<<< HEAD
      I18n.t(:selected_districts, count: districts.count)
    end
    
    def described_name
      districts.map {|d| d.send(name_i18n)}.to_sentence
=======
      "#{districts.count} districts"
    end
    
    def described_name
      districts.map(&:name_en).to_sentence
>>>>>>> multi provinces
    end
  end
end
