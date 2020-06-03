module Channel
  class TelegramChannel < BaseChannel
    def send_message
      RestClient.post(url, params, content_type: "application/json")
      Rails.logger.debug "sent: #{url} #{params}"
    end

    private
      def url
        @url ||= "https://api.telegram.org/bot#{ENV['TELEGRAM_TOKEN']}/sendMessage"
      end

      def params
        {
          chat_id: ticket.message.session_id,
          text: text_message,
          disable_notification: true
        }
      end
  end
end
