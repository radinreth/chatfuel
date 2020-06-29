# frozen_string_literal: true

class AlertNotificationJob < ApplicationJob
  queue_as :default

  def perform(step_value_id)
    step_value = StepValue.find_by(id: step_value_id)

    return if step_value.nil? || step_value.site_setting.nil?

    message = step_value.site_setting.notification_message(step_value.variable_value.display_value)
    service = AlertNotificationService.new(step_value.site_setting.id, message)
    service.notify_immediately
  end
end
