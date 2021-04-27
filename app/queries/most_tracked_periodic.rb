class MostTrackedPeriodic < BasicReport
  
  def dataset
    result_set.each_with_object({}) do |(key, count), hash|
      date, sector = key
      month = format_label(date)

      hash[month] = {
        value: replace_new_line(sector),
        count: count
      } if !hash[month] || hash[month][:count] < count
    end
  end

  private
    def replace_new_line(str)
      str.sub(/\s/, "\n")
    end

    def result_set
      scope = Ticket.filter(@query.options)
      scope = scope.joins(""" INNER JOIN trackings ON
                              trackings.ticket_code = tickets.code""")
      scope = scope.group_by_period(period, "trackings.created_at", format: "%b/%y,%Y")
      scope = scope.group(:sector)
      scope.count
    end
end