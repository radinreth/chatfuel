# frozen_string_literal: true

module Api
  module V1
    class IvrsController < SessionsController
      def create
        Session::IvrJob.perform_later(params[:name], params[:value], params[:address], params[:CallSid])
        head :ok
      end
    end
  end
end
