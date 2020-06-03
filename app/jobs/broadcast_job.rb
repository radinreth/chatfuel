class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    channel = Channel::BaseChannel.new(ticket)
    channel.send
    rescue StandardError => e
      Rails.logger.info "Cannot notified ticket: #{ticket.code} with exception: #{e.message}"
  end
end
