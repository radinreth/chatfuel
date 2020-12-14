class Feedback < Report
  private
    def display_values
      display_ratings.map { |v| [v.raw_value, v.mapping_value] }
    end

    def display_ratings
      @variable.values.reorder(:raw_value).display_ratings
    end

    def colors_mapping
      colors = %w(#B71C1C #FFAB00 #2962FF)
      display_ratings.map(&:raw_value).zip(colors).to_h
    end
end
