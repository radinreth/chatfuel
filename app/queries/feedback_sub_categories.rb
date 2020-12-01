class FeedbackSubCategories < Report
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

    def like_values
      feedback_like.values.map { |v| v.mapping_value }.uniq
    end

    def tuned_dataset
      @values = raw_dataset.values

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
        variable_id, value_id = key
        variable = Variable.find(variable_id)
        variable_value = VariableValue.find(value_id)

        hash[variable.name] ||= {}
        hash[variable.name][variable_value.mapping_value] = count
      end
    end

    def group_count
      StepValue.joins(:message)\
        .where.not(messages: { district_id: ["", "null"] })\
        .where(variable: [feedback_like, feedback_dislike])\
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
