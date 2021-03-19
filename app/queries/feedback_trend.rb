class FeedbackTrend < Feedback
  # def labels
  #   result_set_mapping.keys
  # end

  # { colors: array(3), dataset: array(3), labels: array(6)}
  # labels: x-Axes
  # dataset: 3 (
  #   {
        # label: 'bad',
        # backgroundColor: '',
        # data: array(3)
  #   }
  # )
  
  # def dataset
  #   display_values.map.with_index do |values|
  #     id, raw_value, mapping_value = values
  #     {
  #       label: mapping_value,
  #       backgroundColor: colors_mapping[raw_value],
  #       maxBarThickness: 50,
  #       data: result_set_mapping.values.map { |raw| raw[mapping_value] || 0 }
  #     }
  #   end
  # end

  def chart_options
    mapping.each_with_object({}) do |(pro_code, periods), hash|
      hash[pro_code] ||= {}
      hash[pro_code][:labels] = periods.keys
      hash[pro_code][:dataset] = dataset(periods)
    end
  end
  
  private
    def dataset(periods)
      satisfied.map do |status|
        {
          label: I18n.t(status),
          backgroundColor: colors_mapping[status],
          data: periods.keys.map { |period| periods[period][status] }
        }
      end
    end

    def colors_mapping
      satisfied.zip(COLORS).to_h
    end

    def satisfied
      VariableValue.statuses.keys.reverse
    end

    def mapping
      result.each_with_object({}) do |(key, count), hash|
        province_code, period, value_id = key
        variable_value = VariableValue.find(value_id)

        hash[province_code] ||= {}
        hash[province_code][period] ||= {}
        prev_count = hash[province_code][period][variable_value.status].to_i
        hash[province_code][period][variable_value.status] = (prev_count + count)
      end
    end

    def result
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { province_id: @query.province_codes_without_other })
      scope = scope.where(sessions: { district_id: @query.district_codes_without_other })
      scope = scope.group(:province_id)
      scope = scope.group_by_period(period, "sessions.created_at", format: "%b/%Y")
      scope = scope.group(:variable_value_id)
      scope.count
    end
end
