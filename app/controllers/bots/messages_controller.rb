module Bots
  class MessagesController < BotsController
    before_action :set_variable
    before_action :set_message
    before_action :set_step

    def create
      head :ok
    end

    #TODO Refactor
    def done
      @message.completed! if params[:name] == "done" && params[:value] == "true"
      head :ok
    end

    private
      def set_step
        @step = @message.step_values.create(variable: @variable_value.variable, variable_value: @variable_value)
      end
  end
end
