class FeedbackSubCategories < Report
  def chart_options
    {
      locationName: I18n.t("welcomes.feedback_by_sub_categories", name: location_filter.province_name(:short)),
      ratingLabels: result_set_mapping["all"].keys,
      dataset: dataset
    }
  end

  private
    def dataset
      values.map.with_index do |mapping_value, index|
        {
          label: mapping_value,
          backgroundColor: colors[index],
          data: result_set_mapping["all"].values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def result_set_mapping
      return {} unless result_set

      result_set.each_with_object({}) do |(key, count), hash|
        variable_id, value_id, district_id = key << 'all'
        variable_value = VariableValue.find(value_id)
        variable = variable_value.variable

        hash[district_id] ||= {}
        hash[district_id][I18n.t(variable.name)] ||= {}
        hash[district_id][I18n.t(variable.name)][variable_value.mapping_value] = count
      end
    end

    def sql
      scope = StepValue.filter(StepValue.joins(:message), @query.options)
      scope = scope.where(messages: { district_id: @query.district_codes_without_other })
      scope = scope.where(variable: [like, dislike])
      scope = scope.group(:variable_id, :variable_value_id)
    end

    def colors
      Color.generate(values.count)
    end

    def result_set
      sql.count
    end

    def values
      mapping_values(like) & mapping_values(dislike)
    end

    def mapping_values(obj)
      values = Array.wrap(obj&.values)
      values.map { |v| v.mapping_value }
    end

    def like
      Variable.find_by(name: 'feedback_like')
    end

    def dislike
      Variable.find_by(name: 'feedback_dislike')
    end
end
