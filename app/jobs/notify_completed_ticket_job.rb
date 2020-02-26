class NotifyCompletedTicketJob < ApplicationJob
  queue_as :default

  # TODO: use system setting instead of predefine setting in config/sidekiq.yml
  def perform
    completed = Ticket.completed_with_session

    MessengerService.notify(completed)
  end
end
