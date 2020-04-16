class MessengerService
  class << self
    def notify(completed)
      completed.find_each do |ticket|
        RestClient.post(url, params(ticket), content_type: "application/json") if ENV["ENABLE_FB_NOTIFY"] == "enable"
        # ticket.notified!
      end
    end

    private
      def url
        host = "https://graph.facebook.com"
        path = "v6.0/me/messages"
        token = ENV["FB_PAGE_TOKEN"]

        @url ||= "#{host}/#{path}?access_token=#{token}"
      end

      # TODO: response with pre-defined template
      def params(ticket)
        {
          messaging_type: "RESPONSE",
          recipient: {
            id: ticket.message.session_id
          },
          message: {
            text: "#{ticket.code} is completed!"
          }
        }
      end
  end
end
