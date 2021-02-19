class GenderInfo < BasicReport
  def colors
    Gender::COLORS
  end

  def dataset
    sql.each_with_object({}) do |(raw_gender, count), gender|
      mapping_gender = @query.mapping_variable_value[raw_gender].mapping_value
      gender[mapping_gender] = count
    end
  end

  def sql
    scope = StepValue.filter(@query.options)
    scope = scope.where(variable_value: VariableValue.type_of_user_feedback)
    scope = scope.joins(:session)
    scope = scope.group(:gender)
    scope.count
  end
end
