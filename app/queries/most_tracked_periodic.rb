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
      date, sector = key
      month = format_label(date)

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
    scope = Ticket.filter(@query.options)
    scope = scope.joins(""" INNER JOIN trackings ON
                            trackings.ticket_code = tickets.code""")
    scope = scope.group_by_period(period, "trackings.created_at", format: "%b/%Y")
    scope = scope.group(:sector)
    scope.count
  end
end