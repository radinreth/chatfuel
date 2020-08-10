# frozen_string_literal: true

module Bots::Messages
  class ChatbotController < ::Bots::MessagesController
    private
      def set_variable
        @variable = Variable.find_or_create_by(name: params[:name])
        @variable_value = @variable.values.find_or_create_by(raw_value: params[:value])
      end

      def set_message
        @message = Message.create_or_return(params[:platform_name], content)
      end

      def get_message
        @message = Message.find_by(content: content)
      end

      def content
        @content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id])
      end
  end
end
