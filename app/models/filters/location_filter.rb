class Filters::LocationFilter
  attr_reader :provinces, :districts

  def initialize(provinces = [], districts = [])
    @provinces = provinces
    @districts = districts
  end

  delegate :display_name, :name_i18n, to: :klazz
  delegate :described_name, to: :klazz

  private

  def klazz
    combined = [classify_province, classify_district].join
    klass = "Filters::#{combined}"
    klass.constantize.new(provinces, districts)
  end

  def classify_province
    "#{ Filters::NamedNumber.call(provinces.count) }Province"
  end

  def classify_district
    "#{ Filters::NamedNumber.call(districts.count) }District"
  end
end
