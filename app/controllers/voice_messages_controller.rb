# frozen_string_literal: true

class VoiceMessagesController < ApplicationController
  def create
    @voice = VoiceMessage.create voice_message_params
    @logger = VoiceLogger.new params[:CallSid]
    @logger.call
  end

  private

  def voice_message_params
    params.permit(:CallSid, :address)
  end
end

