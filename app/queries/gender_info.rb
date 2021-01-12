class GenderInfo < Report
  def colors
    Gender::COLORS
  end

  private
    def dataset
      return {} unless @result

      @query.unique_by_genders.inject({}) do |memo, result|
        gender = @query.mapping_variable_value[result.gender]
        memo[gender.mapping_value] = result.gender_count if gender.present?
        memo
      end
    end
end
