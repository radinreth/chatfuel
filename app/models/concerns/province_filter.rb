class ProvinceFilter
  class << self
    def fetch(*codes)
      return beside_pilot_codes if parse(codes).include?(other_code)

      codes.flatten & pilot_codes
    end

    private

      def other_code
        '00'
      end

      def parse(codes)
        return codes.flatten if codes.is_a? Array

        codes.to_s.split(',') rescue []
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
