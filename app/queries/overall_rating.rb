class OverallRating < Feedback
  def labels
    result_set_mapping.keys
  end

  def dataset
    @values = result_set_mapping.values

    display_values.map do |values|
      raw_value, mapping_value = values
      {
        label: mapping_value,
        backgroundColor: colors_mapping[raw_value],
        data: @values.map { |raw| raw[mapping_value] || 0 }
      }
    end
  end

  private
    def result_set_mapping
      return {} unless result_set

      result_set.each_with_object({}).with_index do |((key, count), hash), index|
        district, variable_value = find_objects_by(key)
        location = district.send("name_#{I18n.locale}".to_sym)

        hash[location] ||= {}
        hash[location][variable_value.mapping_value] = count
      end
    end

    def result_set
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { district_id: @query.district_codes_without_other })
      scope = scope.group("sessions.district_id")
      scope = scope.group(:variable_value_id)
      scope.count
    end
end
