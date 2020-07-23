module Bots::Tracks
  class IvrController < ::Bots::TracksController
    def create
      render xml: { Play: "https://api.twilio.com/cowbell.mp3" }.to_xml(root: "Response")
    end

    private
      def set_message
        @content = VoiceMessage.find_or_create_by(callsid: params[:CallSid])
        @message = Message.create_or_return(params[:platform_name], @content)
      end
  end
end
