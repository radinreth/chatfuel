# frozen_string_literal: true

class NotifyCompletedTicketJob < ApplicationJob
  queue_as :default

  # TODO: use system setting instead of predefine setting in config/sidekiq.yml
  # TODO: completed tasks && 7 days window
  def perform
    if ENV["ENABLE_FB_NOTIFY"] == "enable"
      completed = Ticket.completed_with_session
      MessengerService.prepare(completed)
    end
  end
end
