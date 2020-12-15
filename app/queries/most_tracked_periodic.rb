class MostTrackedPeriodic < Report
  def result
    @result = group_count
    self
  end

  def transform
    {
      label: I18n.t("welcomes.most_requested_services"),
      colors: colors,
      dataset: dataset
    }
  end

  private

  def dataset
    @result.each_with_object({}) do |(key, count), hash|
      month, sector = key
      hash[month] = {
        value: replace_new_line(sector),
        count: count
      } if !hash[month] || hash[month][:count] < count
    end
  end

  def replace_new_line(str)
    str.sub(/\s/, "\n")
  end

  def group_count
    period = @query.options[:period].presence || :month

    Ticket.joins("INNER JOIN trackings ON trackings.ticket_code = tickets.code")\
      .group_by_period(period.to_sym, "trackings.created_at", format: "%d/%b")\
      .group(:sector)\
      .count
  end
end
