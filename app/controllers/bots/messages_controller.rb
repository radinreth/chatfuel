module Bots
  class MessagesController < BotsController
    before_action :set_variable, except: :done
    before_action MessageFilter
    before_action :set_step

    def create
      head :ok
    end

    def done
      @message.completed! if @message
    end

    private
      def set_step
        @step = @message.step_values.create(variable: @variable_value.variable, variable_value: @variable_value)
      end
  end
end
