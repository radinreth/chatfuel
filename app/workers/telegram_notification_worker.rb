# frozen_string_literal: true

class TelegramNotificationWorker
  include Sidekiq::Worker

  def perform(variable_value_id)
    variable_value = VariableValue.find_by(id: variable_value_id)
    site_setting = variable_value.try(:variable).try(:site_setting)

    return if site_setting.nil? || variable_value.nil? || !variable_value.feedback_message?

    SiteSettingService.new(variable_value).notify_telegram_group
  end
end
