# TODO split model feedback into text, voice
class VoiceFeedbacksController < ApplicationController
  skip_before_action :authenticate_user_with_guisso!
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
    def variable_params
      _params = params.except(:address, :channel_id, :CallSid).permit!
      name = _params.keys.first
      value = _params[name]
      { name: name, value: value }
    end

    def set_dictionary
      @dictionary ||= VoiceVariable.create_with(value: variable_params[:value]).find_or_create_by(variable_params)
    end

    def step_params
      _params = variable_params
      _params[:act] = _params.delete(:name)
      _params
    end

    def set_site
      @site = Site.find_by(name: params["site"])
    end

    def set_message
      @content = VoiceMessage.find_by(callsid: params[:CallSid])

      @message = Message.find_by content: @content
    end
end
