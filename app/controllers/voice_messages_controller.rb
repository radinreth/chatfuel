# frozen_string_literal: true

class VoiceMessagesController < ApplicationController
  skip_before_action :authenticate_user_without_guisso!
  skip_before_action :verify_authenticity_token

  before_action :set_voice
  before_action :request_verboice
  before_action :update_project_id

  def create
    @message = Message.find_or_create_by(content: @voice)
    @message.steps.create(answer_attributes + audio_attributes)
  end

  private
    def set_voice
      @voice = VoiceMessage.find_or_create_by(voice_message_params)
    end

    def voice_message_params
      _params = params.permit(:CallSid, :address)
      _params[:callsid] = _params.delete(:CallSid)
      _params
    end

    def request_verboice
      @logger ||= VoiceLogger.new(params["CallSid"]).call
    end

    def update_project_id
      @voice.update(project_id: @logger["project"]["id"])
    end

    def answer_attributes
      log_answers = @logger["call_log_answers"]
      @answer_attributes = get_answer_attributes(log_answers)
    end

    def audio_attributes
      log_audios = @logger["call_log_recorded_audios"]
      @audio_attributes = get_audio_attributes(log_audios)
    end

    def get_audio_attributes(audios)
      audios.map do |audio|
        hash = audio.extract!("key", "project_variable_name")
        extractor = AudioExtractor.new(@voice, hash)
        extractor.set_dictionary
        { act: extractor.act, value: extractor.audio_path }
      end
    end

    def get_answer_attributes(answers)
      answers.map do |answer|
        hash = answer.extract!("value", "project_variable_name")
        extractor = AnswerExtractor.new(hash)
        extractor.set_dictionary
        { act: extractor.act, value: extractor.text }
      end
    end
end
