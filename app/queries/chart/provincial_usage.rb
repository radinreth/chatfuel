module Chart::ProvincialUsage
  def provincial_usages
      ProvinceFilter.fetch(province_codes).map do |pro_code|
        ProvincialUsage.new(options, pro_code)
      end
  end
end
