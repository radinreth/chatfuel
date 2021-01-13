class GenderInfo < BasicReport
  def colors
    Gender::COLORS
  end

  def dataset
    genders ||= @query.unique_by_genders

    return {} unless genders.present?

    genders.inject({}) do |memo, result|
      gender = @query.mapping_variable_value[result.gender]
      memo[gender.mapping_value] = result.gender_count if gender.present?
      memo
    end
  end
end
