# frozen_string_literal: true

module Api
  module V1
    class IvrsController < SessionsController
      private
        def set_session
          @session = Session.create_with(platform_name: "Verboice").find_or_create_by(session_id: params[:address])
        end
    end
  end
end
