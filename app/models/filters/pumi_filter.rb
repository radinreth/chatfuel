class Filters::PumiFilter
  def self.pilot_province_codes
    pilot_provinces.map(&:id)
  end

  def self.pilot_district_codes
    pilot_provinces.inject([]) do |codes, province|
      codes += province.pilot_districts.map(&:id)
    end
  end

  private

  def self.pilot_provinces
    Pumi::Province.pilots
  end
end
