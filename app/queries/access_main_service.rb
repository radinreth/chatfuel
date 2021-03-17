class AccessMainService < BasicReport
  def dataset
    result_set.transform_keys do |value_id|
      value = VariableValue.find(value_id)
      value.mapping_value
    end
  end
  
  private
    def result_set
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { province_id: @query.province_codes_without_other })
      scope = scope.where(sessions: { district_id: @query.district_codes_without_other })
      scope = scope.group("variable_value_id")
      scope.count
    end
end
