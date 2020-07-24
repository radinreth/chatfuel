# frozen_string_literal: true

module Bots::Messages
  class IvrController < ::Bots::MessagesController
    def create
      head :ok
    end

    private
      def set_variable
        @variable = VoiceVariable.find_or_create_by(name: params[:name])
        @variable_value = @variable.values.find_or_create_by(raw_value: params[:value])
      end

      def set_message
        content = VoiceMessage.create_with(address: params[:address]).find_or_create_by(callsid: params[:CallSid])
        @message = Message.create_or_return(params[:platform_name], content)
      end
  end
end
