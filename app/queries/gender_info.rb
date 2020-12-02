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
      ["#E25241", "#0448FD", "#75038E"]
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
