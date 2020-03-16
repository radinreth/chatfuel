class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user_without_guisso!
  skip_before_action :verify_authenticity_token
  before_action :set_site

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private
    def feedback_params
      params.permit(:difficulty, :overall, :efficiency, :additional_info, :working_time, :attitude, :provide_info, :process).merge(site_id: @site&.id)
    end

    def set_site
      @site ||= Site.find_by(name: params["site"])
    end
end
