class TicketCollectionDecorator < BaseCollectionDecorator
  def collection
    Ticket.send(@sym)
  end
end
