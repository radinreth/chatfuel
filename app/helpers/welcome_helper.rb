module WelcomeHelper
  def t_name
    "full_name_#{I18n.locale}".to_sym
  end

  def district(district_id)
    Pumi::District.find_by_id(district_id)
  end

  def province(province_id)
    Pumi::Province.find_by_id(province_id)
  end

  def show_location_detail
    described_name ? @location_filter.display_name : I18n.t("dashboard.all_district")
  end

  def described_name
    @location_filter.described_name.presence
  end
end
