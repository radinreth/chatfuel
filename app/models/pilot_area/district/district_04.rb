module PilotArea
  class District::District04 < Base
    def self.all
      super ENV['PILOT_DISTRICT_CODES_FOR_04']
    end
  end
end
