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

  private
    def district
      raise Filters::MultiDistrictException if @codes.length > 1

      Pumi::District.find_by_id(@codes[0])
    end
end