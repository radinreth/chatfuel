# frozen_string_literal: true

class AlertNotificationJob < ApplicationJob
  queue_as :default

  def perform(setting_id, message)
    service = AlertNotificationService.new(setting_id, message)
    service.notify_all
  end
end
