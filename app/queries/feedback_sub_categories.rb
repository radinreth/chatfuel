class FeedbackSubCategories < Report
  def result
    @result = group_count
    self
  end

  def transform
    {
      locationName: I18n.t("welcomes.feedback_by_sub_categories", name: location_filter.province_name(:short)),
      ratingLabels: raw_dataset.keys,
      dataset: values.map.with_index do |mapping_value, index|
        {
          label: mapping_value,
          backgroundColor: colors[index],
          data: raw_dataset.values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    }
  end

  def colors
    Color.generate(values.count)
  end

  private
    def values
      mapping_values(like) & mapping_values(dislike)
    end

    def mapping_values(obj)
      values = Array.wrap(obj&.values)
      values.map { |v| v.mapping_value }
    end

    def raw_dataset
      return {} unless @result

      @result.each_with_object({}) do |(key, count), hash|
        variable_id, value_id = key
        variable = Variable.find(variable_id)
        variable_value = VariableValue.find(value_id)

        hash[I18n.t(variable.name)] ||= {}
        hash[I18n.t(variable.name)][variable_value.mapping_value] = count
      end
    end

    def group_count
      scope = StepValue.filter(StepValue.joins(:message), @query.options)
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.where(variable: [like, dislike])
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
