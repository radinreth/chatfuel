class Filters::LocationFilter
  attr_reader :province, :districts

  def initialize province, districts = []
    @province = province
    @districts = districts
  end

  def field_name
     "name_#{I18n.locale}".to_sym
  end

  def field_address
    "address_#{I18n.locale}".to_sym
  end

  def display_name
    return I18n.t("location_no_district", province: province_name) if !districts?
    return I18n.t("dashboard.all") if !province?
    return district_name if !multi_districts?

    I18n.t("location", district: district_name)
  end

  def province_name
    province? ? province.send(field_address) : I18n.t("dashboard.all")
  end

  def district_name
    return I18n.t(:district_count, count: @districts.count) if multi_districts?

    return districts.first.send(field_name) if districts?

    return ""
  end

  def district_list_name
    return unless multi_districts?
    
    districts.map do |district|
      district.send(field_name)
    end.to_sentence
  end

  private

  def province?
    province.present?
  end

  def multi_districts?
    districts? && districts.count > 1
  end

  def districts?
    districts.present?
  end
end
