class NoProvinceError < StandardError; end
class NoDistrictError < StandardError; end

class LocationFilter
  def initialize(province, district)
    @province = province
    @district = district
  end

  def name
    I18n.t("location", province: province_name, district: district_name)
  rescue NoDistrictError
    I18n.t("location_no_district", province: province_name)
  rescue NoProvinceError
    I18n.t("dashboard.all")
  end

  def label
    "name_#{I18n.locale}".to_sym
  end

  private
    def province_name
      raise NoProvinceError if @province.nil?

      @province.name
    end

    def district_name
      raise NoDistrictError if @district.nil?

      @district.name
    end
end

# location = Location.new province, district
# location.name
