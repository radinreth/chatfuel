# frozen_string_literal: true

class VoiceMessagesController < ApplicationController
  def create
    @voice = VoiceMessage.create(voice_message_params)
    @message = Message.create(content: @voice)

    @logger = VoiceLogger.new(params["CallSid"]).call
    @voice.update(project_id: @logger["project"]["id"])

    log_answers = @logger['call_log_answers']
    answer_attributes = answer_attributes(log_answers)

    log_audios = @logger['call_log_recorded_audios']
    audio_attributes = audio_attributes(log_audios)

    @message.steps.create(answer_attributes + audio_attributes)
  end

  private

  def voice_message_params
    params.permit(:CallSid, :address)
  end

  def audio_attributes(audios)
    @audio_attributes ||= audios.map do |a|
      re = a.extract!('key', 'project_variable_name')
      re['value'] = re.delete('key')
      re['act'] = re.delete('project_variable_name')
      var = AudioVariable.new(@voice, re['value'])
      { act: re['act'], value: var.audio_path }
    end
  end

  def answer_attributes(answers)
    @answer_attributes ||= answers.map do |a|
      re = a.extract!('value', 'project_variable_name')
      re['act'] = re.delete('project_variable_name')
      voice = VoiceVariable.transform(re['act'], re['value'])
      { act: voice.name, value: voice.text }
    end
  end
end
