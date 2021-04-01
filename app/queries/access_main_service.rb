class AccessMainService < BasicReport
  def dataset
    result_set.each_with_object({}) do |(key, count), hash|
      value = VariableValue.find(key)
      prev_count = hash[value.mapping_value].to_i
      hash[value.mapping_value] ||= {}
      hash[value.mapping_value] = (prev_count + count)
    end
  end
  
  private
    def result_set
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { province_id: @query.province_codes })
      scope = scope.group("variable_value_id")
      scope.count
    end
end
