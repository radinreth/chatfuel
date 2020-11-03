class Filters::ProvinceFilter < ::LocationFilter
  def initialize(code)
    @code = code
  end

  def name
    province.send(label)
  end

  private

    def province
      Pumi::Province.find_by_id(@code)
    end
end
