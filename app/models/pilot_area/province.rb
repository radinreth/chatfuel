module PilotArea
  class Province < Base
    attr_reader :pumi_province

    def initialize(province_id)
      @province_id = province_id
    end

    def self.all
      super ENV['PILOT_PROVINCE_CODES']
    end

    def to_pumi
      @pumi_province = Pumi::Province.find_by_id(@province_id)
      self
    end

    def districts
      return district_codes unless @pumi_province

      PilotArea::District::Base.to_pumi(district_codes)
    end

    private

      def district_codes
        PilotArea::District::Base.for(@province_id)
      end
  end
end

