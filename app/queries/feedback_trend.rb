class FeedbackTrend < Feedback
  def chart_options
    province.merge(district)
  end
  
  private

    def province
      dataset(mapping(province_sql))
    end

    def district
      dataset(mapping(district_sql))
    end

    def dataset(_mapping)
      _mapping.each_with_object({}) do |(pro_code, periods), hash|
        hash[pro_code] ||= {}
        hash[pro_code][:labels] = periods.keys
        hash[pro_code][:dataset] = sub_dataset(periods)
      end
    end

    def sub_dataset(periods)
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

    def mapping(collection)
      collection.each_with_object({}) do |(key, count), hash|
        province_code, period, value_id = key
        variable_value = VariableValue.find(value_id)

        hash[province_code] ||= {}
        hash[province_code][period] ||= {}
        prev_count = hash[province_code][period][variable_value.status].to_i
        hash[province_code][period][variable_value.status] = (prev_count + count)
      end
    end

    def sql(location)
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { province_id: @query.province_codes_without_other })
      scope = scope.where(sessions: { district_id: @query.district_codes_without_other })
      scope = scope.group(location)
      scope = scope.group_by_period(period, "sessions.created_at", format: "%b/%Y")
      scope = scope.group(:variable_value_id)
      scope.count
    end

    def province_sql
      sql(:province_id)
    end

    def district_sql
      sql(:district_id)
    end
end
