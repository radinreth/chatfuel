# frozen_string_literal: true

class AlertNotification
  def notify_now(site_id, message)
    raise "Abstract method"
  end
end
