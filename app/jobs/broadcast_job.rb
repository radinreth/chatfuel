class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    RestClient.post url, params(ticket)
    ticket.notified!
    rescue StandardError => e
      p "Cannot notified ticket: #{ticket.it} with exception: #{e.message}"
  end

  private
    def url
      # move to ENV
      # share with read_insight
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
