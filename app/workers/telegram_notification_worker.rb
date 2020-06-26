# frozen_string_literal: true

class TelegramNotificationWorker
  include Sidekiq::Worker

  def perform(step_value_id)
    step_value = StepValue.find_by(id: step_value_id)

    return if step_value.site_setting.nil? || !step_value.site_setting.enable_notification? || step_value.variable_value.nil? || !step_value.variable_value.feedback_message?

    SiteSettingService.new(step_value).notify_telegram_group
  end
end
