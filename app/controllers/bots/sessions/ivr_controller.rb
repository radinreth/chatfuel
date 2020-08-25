# frozen_string_literal: true

module Bots::Messages
  class IvrController < ::Bots::MessagesController
    private
      def set_session
        @session = Session.create_with(platform_name: "Verboice", callsid: params[:CallSid]).find_or_create_by(address: params[:address])
      end
  end
end
