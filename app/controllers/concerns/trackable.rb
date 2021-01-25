module Trackable
  extend ActiveSupport::Concern

  included do
    skip_before_action :restrict_access
    before_action :set_ticket
    before_action :increment_tracks_count
  end

  private
    def set_ticket
      @ticket = Ticket.find_by(code: params["code"])
    end

    def increment_tracks_count
      site = Site.find_by(code: params["code"][0...4]) if params["code"].present?
      site.increment!(:tracks_count) if site
    end
end
