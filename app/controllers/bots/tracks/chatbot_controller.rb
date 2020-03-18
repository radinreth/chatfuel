module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    private
      def set_dictionary
        @dictionary ||= TextVariable.create_with(value: params[:code]).find_or_create_by(name: "tracking_ticket", value: params[:code])
      end

      def message
        @message = TextMessage.find_by(messenger_user_id: params[:messenger_user_id])
      end
  end
end
