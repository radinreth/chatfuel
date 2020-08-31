module Channels
  class TelegramChannel < BaseChannel
    def send_message(ticket)
      return if Setting.telegram_enabled?

      RestClient.post("#{ENV['TG_MESSAGING_URL']}/#{ENV['TG_MESSAGING_TOKEN']}/sendMessage", params(ticket), content_type: "application/json")
      Rails.logger.debug "sent: #{ENV['TG_MESSAGING_URL']} #{params(ticket)}"
    end

    private
      def params(ticket)
        template = response_template(ticket.progress_status, :telegram)
        {
          chat_id: ticket.session.session_id,
          text: text_message(template),
          disable_notification: true
        }
      end
  end
end
