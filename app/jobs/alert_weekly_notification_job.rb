# frozen_string_literal: true

class AlertWeeklyNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AlertNotificationService.new.send_weekly_notification
  end
end
