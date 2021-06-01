# frozen_string_literal: true

module Api
  module V1
    class IvrsController < SessionsController
      def create
        Session::IvrJob.perform_later(ivr_params)
        head :ok
      end
    end
  end
end
