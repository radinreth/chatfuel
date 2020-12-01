# frozen_string_literal: true

module Api
  module V1
    class IvrsController < SessionsController
      private
        def set_session
          @session = Session.find_or_create_by(platform_name: "Verboice", session_id: params[:address], source_id: params[:CallSid])
        end
    end
  end
end
