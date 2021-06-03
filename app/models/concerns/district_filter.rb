class DistrictFilter
  class << self
    def fetch(*codes)
      return beside_pilot_codes if parse(codes).include?(other_code)

      codes.flatten & district_pilot_codes
    end

    private

      def other_code
        '0000'
      end

      def parse(codes)
        return codes.flatten if codes.is_a? Array

        codes.to_s.split(',') rescue []
      end

      def beside_pilot_codes
        all_district_codes - district_pilot_codes
      end

      def district_pilot_codes
        Pumi::Province.pilots.inject([]) do |codes, province|
          codes += province.pilot_districts.map(&:id)
        end - Filters::LocationFilter.dump_codes rescue []
      end

      def all_district_codes
        Session.pluck(:district_id).uniq - Filters::LocationFilter.dump_codes
      end
  end
end
