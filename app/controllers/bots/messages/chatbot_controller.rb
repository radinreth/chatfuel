# frozen_string_literal: true

module Bots::Messages
  class ChatbotController < ::Bots::MessagesController
    private
      def set_message
        content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id])
        @message = Message.create_or_return(params[:platform_name], content)
      end
  end
end
