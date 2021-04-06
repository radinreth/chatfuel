module PilotArea
  class Province < Base
    def initialize(province_id)
      @province_id = province_id
    end

    def self.all
      super ENV['PILOT_PROVINCE_CODES']
    end

    def districts
      PilotArea::District::Base.for(@province_id)
    end
  end
end

