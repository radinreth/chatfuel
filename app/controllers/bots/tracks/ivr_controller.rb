module Bots::Tracks
  class IvrController < BotsController
    private
      def set_dictionary
        @dictionary ||= VoiceVariable.create_with(value: params[:code]).find_or_create_by(name: "tracking_ticket", value: params[:code])
      end

      def message
        @message = VoiceMessage.find_by(callsid: params[:CallSid])
      end
  end
end
