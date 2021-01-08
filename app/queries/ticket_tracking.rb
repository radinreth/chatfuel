class TicketTracking < Report
  def dataset
    @query.number_of_tracking_tickets
  end
end
