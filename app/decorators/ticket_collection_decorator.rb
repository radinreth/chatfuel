class TicketCollectionDecorator < BaseCollectionDecorator
  def collection
    Ticket.send(@sym)
  end

  def total
    collection.count
  end

  def avg
    number_to_percentage(total / period.duration_in_day)
  end

  def to_partial_path
    'tickets/ticket'
  end
end
