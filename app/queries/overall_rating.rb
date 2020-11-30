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
      @variable.values.display_ratings.map { |v| v.mapping_value }
    end

    # [[98, "Acceptable"], [97, "Bad"], [115, "Good"]]
    def tuned_dataset
      @values = raw_dataset.values

      display_ratings.map.with_index do |mapping_value, index|
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
        district, variable_value = find_objects_by(key)
        location = district.send("name_#{I18n.locale}".to_sym)

        hash[location] ||= {}
        hash[location][variable_value.mapping_value] = count
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
