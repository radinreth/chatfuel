class Filters::LocationFilter
  attr_reader :provinces, :districts

  def initialize(provinces = [], districts = [])
    @provinces = provinces
    @districts = districts
  end

  def display_name
    # 0 province, 0 district > all
    #   ZeroProvinceZeroDistrict
    # 1 province, 0 district
    # 1 province, 1 district
    # 1 province, * district
    # * province, 0 district
    # * province, 1 district
    # * province, * district
    klass = [classify_province, classify_district].join
    namespace = "Filters::#{klass}"
    namespace.constantize.new(provinces, districts).display_name

    # return I18n.t("location_no_district", provinces: provinces_name) if province? && !districts?
    # return I18n.t("dashboard.all") if !province?
    # return district_name if !multi_districts?

    # I18n.t("location", district: district_name)
  end

  def classify_province
    "#{ str(provinces.count) }Province"
  end

  def classify_district
    "#{ str(districts.count) }District"
  end

  def str number
    case
    when number == 0 then 'Zero'
    when number == 1 then 'One'
    when number > 1 then 'Many'
    end
  end

  # def provinces_name(type = :long)
  #   name_type = type == :short ? field_name : field_address
  #   provinces? ? provinces.map{|p| p.send(name_type) }.to_sentence : I18n.t("dashboard.all")
  # end

  # def district_name
  #   return I18n.t(:district_count, count: @districts.count) if multi_districts?

  #   return districts.first.send(field_name) if districts?

  #   return ""
  # end

  def district_list_name
    ""
    # return unless multi_districts?
    
    # full_district_list_name
  end

  def full_district_list_name
    # Array.wrap(districts).map { |district| district.send(field_name) }.to_sentence
  end

  def field_name
    "name_#{I18n.locale}".to_sym
  end

  # def field_address
  #   "address_#{I18n.locale}".to_sym
  # end

  private

  def province?
    districts.count == 1
  end

  def provinces?
    districts.count > 1
  end

  def district?
    districts.count == 1
  end

  def districts?
    districts.count > 1
  end
end
