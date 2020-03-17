# TODO split model feedback into text, voice
class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user_without_guisso!
  skip_before_action :verify_authenticity_token

  before_action :set_dictionary
  before_action :set_message
  before_action :set_site

  def create
    @step = @message.steps.create(step_params)
    @feedback = @step.build_feedback(site_id: @site&.id)

    if @feedback.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private
    def set_dictionary
      klass = "#{params[:klass]}Variable".constantize

      @dictionary ||= klass.create_with(value: params[:value]).find_or_create_by(variable_params)
    end

    def variable_params
      _params = params.permit(:act, :value)
      _params[:name] = _params.delete(:act)
      _params
    end

    def step_params
      params.permit(:act, :value)
    end

    def set_site
      @site = Site.find_by(name: params["site"])
    end

    def set_message
      klass_type = params[:klass]
      message_params = "#{klass_type}MessageParams".underscore

      @content = "#{klass_type}Message".constantize.find_by send(message_params.to_sym)

      @message = Message.find_by content: @content
    end

    def text_message_params
      { messenger_user_id: params[:messenger_user_id] }
    end

    def voice_message_params
      { callsid: params[:CallSid] }
    end
end
