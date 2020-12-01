class GenderInfo < Report
  def result
    @result = @query.unique_by_genders
    self
  end

  def transform
    {
      colors: generate_colors,
      dataset: dataset
    }
  end

  private
    def generate_colors
      ["#469BA2", "#C2E792", "#D77256"]
    end

    def dataset
      return {} unless @result

      @result.inject({}) do |memo, result|
        gender = @query.mapping_variable_value[result.gender]
        memo[gender.mapping_value] = result.gender_count
        memo
      end
    end
end