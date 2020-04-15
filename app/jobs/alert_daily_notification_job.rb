# frozen_string_literal: true

class AlertDailyNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AlertNotificationService.new.send_daily_notification
  end
end
