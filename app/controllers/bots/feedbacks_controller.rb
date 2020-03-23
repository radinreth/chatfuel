module Bots
  class FeedbacksController < BotsController
    before_action :set_dictionary
    before_action :set_message
    before_action :set_site

    def create
      @step = @message.steps.create(step_params)
      @feedback = @step.build_feedback(site_id: @site&.id)
      @feedback.variable = @dictionary

      if @feedback.save
        head :ok
      else
        head :unprocessable_entity
      end
    end

    private
      def set_site
        @site = Site.find_by(name: params["site"])
      end
  end
end
