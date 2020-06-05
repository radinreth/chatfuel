module Channels
  class TelegramChannel < BaseChannel
    def send_message(ticket)
      RestClient.post(url, params(ticket), content_type: "application/json")
      Rails.logger.debug "sent: #{url} #{params}"
    end

    private
      def url
        @url ||= "https://api.telegram.org/bot#{ENV['TELEGRAM_TOKEN']}/sendMessage"
      end

      def params(ticket)
        template = response_template ticket
        {
          chat_id: ticket.message.session_id,
          text: text_message(template),
          disable_notification: true
        }
      end
  end
end
