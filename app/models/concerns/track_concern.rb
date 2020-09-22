module TrackConcern
  extend ActiveSupport::Concern

  included do
    after_create :create_tracking, if: -> { variable.is_ticket_tracking? }
  end

  def create_tracking
    Tracking.create(status: variable_value.ticket_status, tracking_datetime: created_at, message: message)
  end
end
