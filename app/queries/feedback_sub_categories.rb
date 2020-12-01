class FeedbackSubCategories < Report
  def result
    @result = group_count
    self
  end

  def transform
    ["0204", "0212"].each_with_object({}) do |district_id, hash|
      hash[district_id] ||= {}
      hash[district_id][:ratingLabels] = raw_dataset[district_id].keys
      hash[district_id][:dataset] = tuned_dataset(district_id)
    end
  end

  private
    def like_values
      feedback_like.values.map { |v| v.mapping_value }.uniq
    end

    def tuned_dataset(key)
      @values = raw_dataset[key].values

      like_values.map.with_index do |mapping_value, index|
        {
          label: mapping_value,
          backgroundColor: generate_colors[index],
          data: @values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def raw_dataset
      return {} unless @result

      @result.each_with_object({}).with_index do |((key, count), hash), index|
        district_id, variable_id, value_id = key
        district = ::Pumi::District.find_by_id(district_id)
        variable = Variable.find(variable_id)
        variable_value = VariableValue.find(value_id)

        hash[district_id] ||= {}
        hash[district_id][variable.name] ||= {}
        hash[district_id][variable.name][variable_value.mapping_value] = count
      end
    end

    def group_count
      StepValue.joins(:message)\
        .where(messages: { district_id: ["0204", "0212"] })\
        .where(variable: [feedback_like, feedback_dislike])\
        .group("messages.district_id")\
        .group(:variable_id, :variable_value_id)\
        .count
    end

    def feedback_like
      Variable.find_by(name: 'feedback_like')
    end

    def feedback_dislike
      Variable.find_by(name: 'feedback_dislike')
    end
end
