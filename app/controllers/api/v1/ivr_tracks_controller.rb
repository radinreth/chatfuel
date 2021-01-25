# frozen_string_literal: true

module Api
  module V1
    class IvrTracksController < ApplicationController
      include Trackable

      before_action :set_template

      def show
        if @template && @template.audio.attached?
          render xml: { Play: helpers.polymorphic_url(@template.audio) }.to_xml(root: "Response")
        else
          render xml: { Play: helpers.audio_url("wrong-id.mp3") }.to_xml(root: "Response")
        end
      end

      private
        def set_template
          @template = VerboiceTemplate.find_by(status: @ticket&.progress_status)
        end
    end
  end
end
