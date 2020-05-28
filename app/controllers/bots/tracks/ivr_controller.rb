module Bots::Tracks
  class IvrController < ::Bots::TracksController
    private
      def set_message
        @content = VoiceMessage.find_or_create_by(callsid: params[:CallSid])
        @message = Message.create_or_return(params[:platform_name], @content)
      end
  end
end
