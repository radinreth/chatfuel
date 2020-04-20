module Channel
  class TelegramChannel < BaseChannel
    def send
      RestClient.post(url, params(ticket), content_type: "application/json")
      Rails.logger.debug "sent: #{url} #{params(@ticket)}"
    end

    private
      def url
        @url ||= "https://api.telegram.org/bot#{ENV['TELEGRAM_TOKEN']}/sendMessage"
      end

      def params(ticket)
        {
          chat_id: ticket.message.session_id,
          text: text_message,
          disable_notification: true
        }
      end
  end
end
