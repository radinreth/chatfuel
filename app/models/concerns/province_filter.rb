class ProvinceFilter < AreaFilter
  class << self
    private
      def other_code
        '00'
      end

      def codes_beside_pilot
        Session.province_ids - pilot_codes
      end

      def pilot_codes
        Filters::PumiFilter.pilot_province_codes
      end
  end
end
