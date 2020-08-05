module Channels
  class MessengerChannel < BaseChannel
    def send_message(ticket)
      return if ENV["ENABLE_FB_NOTIFY"] != "enable"

      if ticket.message.reachable_period?
        RestClient.post("#{ENV['FB_MESSAGING_URL']}?access_token=#{ENV['FB_MESSAGING_TOKEN']}", params(ticket), content_type: "application/json")
        Rails.logger.info "Sent: #{ENV['FB_MESSAGING_URL']} #{params(ticket)}"
      end
    end

    private
      def params(ticket)
        template = response_template(ticket.progress_status, :messenger)
        {
          messaging_type: "MESSAGE_TAG",
          tag: "CONFIRMED_EVENT_UPDATE",
          recipient: {
            id: ticket.message.try(:session_id)
          },
          message: {
            text: text_message(template)
          }
        }
      end
  end
end
