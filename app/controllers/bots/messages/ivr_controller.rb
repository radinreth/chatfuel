# frozen_string_literal: true

module Bots::Messages
  class IvrController < ::Bots::MessagesController
    before_action :request_verboice
    before_action :update_project_id

    def create
      @message = Message.find_or_create_by(content: @voice)
      @message.steps.create(answer_attributes + audio_attributes)
    end
  
    private
      def set_variable
        @variable = VoiceVariable.find_or_create_by(name: params[:name])
        @variable_value = @variable.values.find_or_create_by(raw_value: params[:value])
      end

      def set_message
        content = VoiceMessage.find_or_create_by(voice_message_params)
        @message = Message.create_or_return(params[:platform_name], content)
      end

      def voice_message_params
        voice_params = params.permit(:CallSid, :address)
        voice_params[:callsid] = voice_params.delete(:CallSid)
        voice_params
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
end
