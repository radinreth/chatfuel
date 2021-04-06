module PilotArea
  class District::District02 < Base
    def self.all
      super ENV['PILOT_DISTRICT_CODES_FOR_02']
    end
  end
end
