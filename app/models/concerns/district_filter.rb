class DistrictFilter < AreaFilter
  class << self
    private
      def other_code
        '0000'
      end

      def codes_beside_pilot
        Session.district_ids - pilot_codes
      end

      def pilot_codes
        Filters::PumiFilter.pilot_district_codes
      end
  end
end
