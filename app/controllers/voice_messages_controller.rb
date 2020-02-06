# frozen_string_literal: true

class VoiceMessagesController < ApplicationController
  def create
    @voice = VoiceMessage.create(voice_message_params)
    @message = Message.create(content: @voice)
    @logger = VoiceLogger.new(params["CallSid"])
    answer_attributes = answer_attributes(@logger.call)
    @message.steps.create(answer_attributes)
    #@voice.voice_answers.create(answer_attributes)
  end

  private

  def voice_message_params
    params.permit(:CallSid, :address)
  end

  def answer_attributes(answers)
    @answer_attributes ||= answers.map do |a|
      re = a.extract!('value', 'project_variable_name')
      re['act'] = re.delete('project_variable_name')
      re
    end
  end
end

