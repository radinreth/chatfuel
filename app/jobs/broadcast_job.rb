class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    channel = Channel::BaseChannel.get(ticket.platform_name)
    channel.send_message(ticket) if ticket.session
  rescue StandardError => e
    Rails.logger.info "Cannot notified ticket: #{ticket.code} with exception: #{e.message}"
  end
end
