class Filters::MultiDistrictException < StandardError
end

class Filters::DistrictFilter < ::LocationFilter
  def initialize(codes)
    @codes = codes
  end

  def name
    district.send(label)
  rescue Filters::MultiDistrictException
    I18n.t("district_count", count: @codes.length)
  end

  def names
    @codes.map do |code|
      district = Pumi::District.find_by_id(code)
      district.send(label)
    end.to_sentence
  end

  private
    def district
      raise Filters::MultiDistrictException if @codes.length > 1

      Pumi::District.find_by_id(@codes[0])
    end
end
