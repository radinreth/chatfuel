# frozen_string_literal: true

class VoiceMessagesController < ApplicationController
  def create
    @voice = VoiceMessage.create(voice_message_params)
    @logger = VoiceLogger.new(params[:CallSid])
    answer_attributes = answer_attributes(@logger.call)
    @voice.voice_answers.create(answer_attributes)
  end

  private

  def voice_message_params
    params.permit(:CallSid, :address)
  end

  def answer_attributes(answers)
    @answer_attributes ||= answers.map do |a|
      a.extract!(:value, :project_variable_name)
    end
  end
end

