class VerboicesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    @voice = Voice.where(call_sid: params[:CallSid]).first_or_initialize

    @voice.call_sid = params[:CallSid]
    @voice.status = params[:CallStatus]
    @voice.from = params[:From]
    @voice.call_duration = params[:CallDuration]
    @voice.save

    head :ok
  end

  private

  def voice_params
    params.permit(:CallSid, :CallStatus, :From, :CallDuration)
  end
end
