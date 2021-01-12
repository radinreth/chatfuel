class AccessMainService < Report
  private
    def dataset
      result_set.transform_keys do |value_id|
        value = VariableValue.find(value_id)
        value.mapping_value
      end
    end

    def result_set
      scope = StepValue.filter(@variable.step_values, @query.options)
      scope = scope.joins(:message)
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.group("variable_value_id")
      scope.count
    end
end
