module Bots::Messages
  class ChatbotController < ::Bots::MessagesController
    def create
      head :ok
    end
    
    private
      def set_variable
        @variable = TextVariable.find_or_create_by(name: params[:name])
        @variable_value = @variable.values.find_or_create_by(raw_value: params[:value])
      end

      def set_message
        content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id])
        @message = Message.create_or_return(params[:platform_name], content)
      end
  end
end
