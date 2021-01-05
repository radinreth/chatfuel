class TicketTracking < Report
  def result
    @result = @query.number_of_tracking_tickets
    self
  end

  def transform
    {
      colors: colors,
      dataset: @result
    }
  end
end
