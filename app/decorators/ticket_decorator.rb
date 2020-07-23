class TicketDecorator
  attr_reader :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  delegate_missing_to :ticket

  def status
    I18n.t("tickets.status_#{ticket.status}.status")
  end

  def description
    I18n.t(
      "tickets.status_#{ticket.status}.description",
      requested_date: ticket.requested_date,
      approved_date: ticket.approved_date,
      delivery_date: ticket.delivery_date
    )
  end

  def invalid?
    @ticket.status == "invalid"
  end
end
