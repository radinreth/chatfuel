module Bots::Messages
  class ChatbotController < BotsController
    before_action :set_variable
    before_action :set_message
    before_action :set_site
    before_action :set_step

    def create
      head :ok
    end

    def done
      @message.completed! if params[:name] == "done" && params[:value] == "true"
      head :ok
    end

    private
      def set_message
        content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id])
        @message = Message.create_or_return(content)
      end

      def set_step
        @message.steps.create(value: @variable_value, site: @site)
      end

      def set_site
        @site = Site.find_by(name: params["value"]) if params["name"] == "feedback_site"
      end

      def set_variable
        @variable = TextVariable.find_or_create_by(name: variable_params[:name])
        @variable_value = @variable.values.find_or_create_by(raw_value: variable_params[:value])
      end

      def variable_params
        params.permit(:name, :value)
      end
  end
end
