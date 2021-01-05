class GenderInfo < Report
  def result
    @result = @query.unique_by_genders
    self
  end

  def transform
    {
      colors: Gender::COLORS,
      dataset: dataset
    }
  end

  private
    def dataset
      return {} unless @result

      @result.inject({}) do |memo, result|
        gender = @query.mapping_variable_value[result.gender]
        memo[gender.mapping_value] = result.gender_count if gender.present?
        memo
      end
    end
end
