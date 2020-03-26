module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    private
      def set_dictionary
        # @dictionary ||= TextVariable.create_with(value: params[:code]).find_or_create_by(name: "tracking_ticket", value: params[:code])
        @dictionary ||= TextVariable.find_or_create_by(name: "tracking_ticket")
        @dictionary.values.create(raw_value: params[:code])
      end

      def set_message
        @message = TextMessage.find_by(messenger_user_id: params[:messenger_user_id])
      end
  end
end
