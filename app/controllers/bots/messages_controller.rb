module Bots
  class MessagesController < BotsController
    before_action :set_variable, only: :create
    before_action :set_message, only: :create
    before_action :set_step, only: :create

    def create
      head :ok
    end

    def mark_as_completed
      content = TextMessage.find_by(messenger_user_id: params[:messenger_user_id])
      @message = Message.find_by(content: content)
      @message&.completed!
    end

    private
      def set_step
        @step = @message.step_values.create(variable: @variable_value.variable, variable_value: @variable_value)
      end
  end
end
