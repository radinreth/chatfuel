# frozen_string_literal: true

module Bots::Messages
  class IvrController < ::Bots::MessagesController
    private
      def set_message
        content = VoiceMessage.create_with(address: params[:address]).find_or_create_by(callsid: params[:CallSid])
        @message = Message.create_or_return(params[:platform_name], content)
      end
  end
end
