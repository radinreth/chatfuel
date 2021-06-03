class DistrictFilter < AreaFilter
  class << self
    private
      def other_code
        '0000'
      end

      def beside_pilot_codes
        all_codes - pilot_codes
      end

      def pilot_codes
        Pumi::Province.pilots.inject([]) do |codes, province|
          codes += province.pilot_districts.map(&:id)
        end - Filters::LocationFilter.dump_codes rescue []
      end

      def all_codes
        Session.pluck(:district_id).uniq - Filters::LocationFilter.dump_codes
      end
  end
end
