# frozen_string_literal: true

module Bots::Sessions
  class IvrController < ::Bots::SessionsController
    private
      def set_session
        @session = Session.create_with(platform_name: "Verboice", callsid: params[:CallSid]).find_or_create_by(session_id: params[:address])
      end
  end
end
