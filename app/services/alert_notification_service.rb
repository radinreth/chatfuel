# frozen_string_literal: true

class AlertNotificationService
  CHANNEL_NAMES = ["Notification::Telegram"]

  def initialize(setting_id, message)
    @setting_id = setting_id
    @message = message
  end

  def notify_all
    setting = SiteSetting.find(@setting_id)
    return unless setting.try(:immediately?)

    CHANNEL_NAMES.each do |channel_name|
      channel_factory(channel_name).notify_now(@setting_id, @message)
    end
  end

  private
    def channel_factory(channel_name)
      channel_name.constantize.new
    end
end
