module PilotArea
  class District::Base < Base
    def self.for(province_id)
      district = "PilotArea::District::District#{province_id}".constantize
      district.all
    rescue
      raise "Must implement method .all in pilot_area/district/district**.rb"
    end

    def self.to_pumi(district_codes)
      district_codes.map do |district_code|
        Pumi::District.find_by_id(district_code)
      end
    end
  end
end
