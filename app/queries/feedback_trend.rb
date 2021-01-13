class FeedbackTrend < Feedback

  private

    def labels
      result_set_mapping.keys
    end

    def dataset
      @values = result_set_mapping.values

      display_values.map.with_index do |values|
        raw_value, mapping_value = values
        {
          label: mapping_value,
          backgroundColor: colors_mapping[raw_value],
          data: @values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def result_set_mapping
      return {} unless result_set

      result_set.each_with_object({}).with_index do |((key, count), hash), index|
        month, value_id = key
        variable_value = VariableValue.find(value_id)

        hash[month] ||= {}
        hash[month][variable_value.mapping_value] = count
      end
    end

    def result_set
      scope = StepValue.filter(@variable.step_values, @query.options)
      scope = scope.joins(:message)
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.group_by_month("messages.created_at", format: "%b")
      scope = scope.group(:variable_value_id)
      scope.count
    end
end
