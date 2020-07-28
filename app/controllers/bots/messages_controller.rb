module Bots
  class MessagesController < BotsController
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
      def set_step
        @step = @message.steps.create(value: @variable_value)
        @step.update(site: @site) if @site
      end

      def set_site
        @site = Site.find_by(name: params["value"]) if params["name"] == "feedback_site"
      end
  end
end
