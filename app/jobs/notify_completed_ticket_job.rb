class NotifyCompletedTicketJob < ApplicationJob
  queue_as :default

  def perform
    completed = Ticket.completed_with_session

    MessengerService.notify(completed)
  end
end
