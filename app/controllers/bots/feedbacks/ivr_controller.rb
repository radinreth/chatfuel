module Bots::Feedbacks
  class IvrController < ::Bots::FeedbacksController
    private
      def set_dictionary
        @dictionary ||= VoiceVariable.create_with(value: variable_params[:value]).find_or_create_by(variable_params)
      end

      def variable_params
        _params = params.except(:address, :channel_id, :CallSid).permit!
        name = _params.keys.first
        value = _params[name]
        { name: name, value: value }
      end

      def step_params
        _params = variable_params
        _params[:act] = _params.delete(:name)
        _params
      end

      def set_message
        @content = VoiceMessage.find_by(callsid: params[:CallSid])

        @message = Message.find_by(content: @content)
      end
  end
end
