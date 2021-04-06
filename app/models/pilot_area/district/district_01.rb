module PilotArea
  class District::District01 < Base
    def self.all
      super ENV['PILOT_DISTRICT_CODES_FOR_01']
    end
  end
end
