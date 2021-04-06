module PilotArea
  class District::Base < Base
    def self.for(province_id)
      district = "PilotArea::District::District#{province_id}".constantize
      district.all
    rescue
      raise "Unknown `District#{province_id}`. "\
            "Must implement method .all in pilot_area/district/district**.rb"
    end
  end
end
