module Channel
  class MessengerChannel < BaseChannel
    def send_message
      RestClient.post(url, params, content_type: "application/json")
      Rails.logger.debug "sent: #{url} #{params}"
    end

    private
      def url
        @uri ||= "https://graph.facebook.com/v6.0/me/messages?access_token=#{ENV["FB_PAGE_TOKEN"]}"
      end

      def params
        {
          messaging_type: "MESSAGE_TAG",
          tag: "CONFIRMED_EVENT_UPDATE",
          recipient: {
            id: ticket.message.session_id
          },
          message: {
            text: text_message
          }
        }
      end
  end
end
