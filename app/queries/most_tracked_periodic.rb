class MostTrackedPeriodic < BasicReport
  
  def dataset
    result_set.each_with_object({}) do |(key, count), hash|
      date, sector = key
      month = format_label(date)

    def label
      { label: I18n.t("welcomes.most_requested_services") }
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
      scope = scope.group_by_period(period, "trackings.created_at", format: "%b/%Y")
      scope = scope.group(:sector)
      scope.count
    end
end
