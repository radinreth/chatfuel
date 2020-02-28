# TODO: add spec

class TicketCollectionDecorator < BaseCollectionDecorator
  def collection
    Ticket.send(@sym)
  end

  def to_partial_path
    'tickets/ticket'
  end
end
