class OverallRating < Feedback
  def result
    @result = group_count
    self
  end

  def transform
    {
      ratingLabels: raw_dataset.keys,
      dataset: tuned_dataset
    }
  end

  private
    def tuned_dataset
      @values = raw_dataset.values

      display_values.map do |values|
        raw_value, mapping_value = values
        {
          label: mapping_value,
          backgroundColor: colors_mapping[raw_value],
          data: @values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def raw_dataset
      return {} unless @result

      @result.each_with_object({}).with_index do |((key, count), hash), index|
        district, variable_value = find_objects_by(key)
        location = district.send("name_#{I18n.locale}".to_sym)

        hash[location] ||= {}
        hash[location][variable_value.mapping_value] = count
      end
    end

    def group_count
      scope = @variable.step_values.joins(:message)
      scope = scope.where.not(messages: { district_id: ["", "null"] })
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.group("messages.district_id")
      scope = scope.group(:variable_value_id)
      scope = scope.count
      scope
    end
end
