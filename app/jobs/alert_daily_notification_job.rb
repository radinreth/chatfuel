# frozen_string_literal: true

class AlertDailyNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
