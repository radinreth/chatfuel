class FeedbackSubCategories < Report
  def result
    @result = group_count
    self
  end

  def transform
    @query.district_codes_without_other.each_with_object({}) do |district_id, hash|
      hash[district_id] ||= {}
      district = ::Pumi::District.find_by_id(district_id)
      hash[district_id][:locationName] = district.send("name_#{I18n.locale}".to_sym)
      hash[district_id][:ratingLabels] = raw_dataset[district_id].keys rescue []
      hash[district_id][:dataset] = tuned_dataset(district_id)
    end
  end

  private
    def values
      mapping_values(like) & mapping_values(dislike)
    end

    def mapping_values(obj)
      values = Array.wrap(obj&.values)
      values.map { |v| v.mapping_value }
    end

    def tuned_dataset(key)
      @values = raw_dataset[key].values rescue []

      values.map.with_index do |mapping_value, index|
        {
          label: mapping_value,
          backgroundColor: colors[index],
          data: @values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def raw_dataset
      return {} unless @result

      @result.each_with_object({}).with_index do |((key, count), hash), index|
        district_id, variable_id, value_id = key
        variable = Variable.find(variable_id)
        variable_value = VariableValue.find(value_id)

        hash[district_id] ||= {}
        hash[district_id][I18n.t(variable.name)] ||= {}
        hash[district_id][I18n.t(variable.name)][variable_value.mapping_value] = count
      end
    end

    def group_count
      scope = StepValue.filter(StepValue.joins(:message), @query.options)
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.where(variable: [like, dislike])
      scope = scope.group("messages.district_id")
      scope = scope.group(:variable_id, :variable_value_id)
      scope.count
    end

    def like
      Variable.find_by(name: 'feedback_like')
    end

    def dislike
      Variable.find_by(name: 'feedback_dislike')
    end
end
