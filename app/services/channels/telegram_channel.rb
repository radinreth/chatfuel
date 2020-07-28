module Channels
  class TelegramChannel < BaseChannel
    def send_message(ticket)
      RestClient.post(ENV['TG_MESSAGING_ENDPOINT'], params(ticket), content_type: "application/json")
      Rails.logger.debug "sent: #{ENV['TG_MESSAGING_ENDPOINT']} #{params(ticket)}"
    end

    private
      def params(ticket)
        template = response_template(ticket)
        {
          chat_id: ticket.message.session_id,
          text: text_message(template),
          disable_notification: true
        }
      end
  end
end
