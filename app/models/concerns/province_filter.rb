class ProvinceFilter < AreaFilter
  class << self
    private
      def other_code
        '00'
      end

      def beside_pilot_codes
        all_codes - pilot_codes
      end

      def pilot_codes
        Pumi::Province.pilots.map(&:id)
      end

      def all_codes
        Session.pluck(:province_id).uniq - Filters::LocationFilter.dump_codes
      end
  end
end
