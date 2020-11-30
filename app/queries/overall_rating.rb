class OverallRating < Report
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

    def display_ratings
      @variable.values.display_ratings.ids
    end

    # [[98, "Acceptable"], [97, "Bad"], [115, "Good"]]
    def tuned_dataset
      @values = raw_dataset.values

      display_ratings.map do |value_id|
        {
          label: value_id,
          data: @values.map { |raw| raw[value_id] || 0 }
        }
      end
    end

    def raw_dataset
      return {} unless @result

      @result.each_with_object({}).with_index do |((key, count), hash), index|
        location, value = key

        hash[location] ||= {}
        hash[location][value] = count
      end
    end

    def group_count
      # only display_ratings values should be shown
      @variable.step_values.joins(:message)\
        .where.not(messages: { district_id: ["", "null"] })\
        .group("messages.district_id")\
        .group(:variable_value_id)\
        .count
    end
end
