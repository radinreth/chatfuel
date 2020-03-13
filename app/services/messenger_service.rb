class MessengerService
  def self.notify(completed)
    completed.find_each do |ticket|
      RestClient.post url, params(ticket) if ENV["ENABLE_FB_NOTIFY"] == "enable"
      ticket.notified!
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
        message_type: "RESPONSE",
        recipient: {
          id: ticket.message.session_id
        },
        message: {
          text: "#{ticket.code} is completed!"
        }
      }
    end
end
