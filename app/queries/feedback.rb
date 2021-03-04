class Feedback < GenericReport
  COLORS = %w(#f63e3e #ffbc00 #1cc88a)

  private
    def display_values
      display_ratings.map { |v| [v.id, v.raw_value, v.mapping_value] }
    end

    def display_ratings
      @variable.values.reorder(:raw_value).display_ratings
    end

    def colors_mapping
      display_ratings.map(&:raw_value).zip(COLORS).to_h
    end
end
