module Bots::Tracks
  class IvrController < ::Bots::TracksController
    before_action :set_template

    def create
      if @template && @template.audio.attached?
        render xml: { Play: helpers.url_for(@template.audio) }.to_xml(root: "Response")
      else
        render xml: { Play: helpers.audio_url("wrong-id.mp3") }.to_xml(root: "Response")
      end
    end

    private
      def set_template
        @template = VerboiceTemplate.find_by(status: @ticket.progress_status)
      end
  end
end
