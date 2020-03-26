module Bots::Feedbacks
  class ChatbotController < ::Bots::FeedbacksController
    private
      def set_dictionary
        # @dictionary ||= TextVariable.create_with(value: params[:value]).find_or_create_by(variable_params)
        @dictionary ||= TextVariable.find_or_create_by(name: text_variable_params[:name])
        begin
          @value ||= @dictionary.values.create!(raw_value: text_variable_params[:value])
        rescue ActiveRecord::RecordInvalid
          @value ||= @dictionary.values.find_by(raw_value: text_variable_params[:value])
        end
      end

      def text_variable_params
        _params = params.permit(:act, :value)
        _params[:name] = _params.delete(:act)
        _params
      end

      def step_params
        params.permit(:act, :value)
      end

      def set_message
        @content = TextMessage.find_by({ messenger_user_id: params[:messenger_user_id] })

        @message = Message.find_by(content: @content)
      end
  end
end
