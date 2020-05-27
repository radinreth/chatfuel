module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    private
      def set_message
        @content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id])
        @message = Message.create_or_return(params[:platform_name], @content)
      end

      def set_site
        @site = Site.find_by(code: params[:code][0...4])
      end

      def set_ticket
        @ticket ||= Ticket.find_by(code: normalized_code)
      end
  end
end
