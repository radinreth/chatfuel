# frozen_string_literal: true

class AlertNotificationService
  CHANNEL_NAMES = ["Notification::Telegram"]

  def initialize(setting_id, message)
    @setting_id = setting_id
    @message = message
  end

  def notify_all
    setting = SiteSetting.find_by(id: @setting_id, message_frequency: SiteSetting.message_frequencies[:immediately])
    return if setting.nil?

    CHANNEL_NAMES.each do |channel_name|
      channel_factory(channel_name).notify_now(@setting_id, @message)
    end
  end

  def send_daily_notification
    SiteSetting.daily.each do |setting|
      site = setting.site
      next if site.feedbacks.yesterday.count.zero?
    end
  end

  def send_weekly_notification
    SiteSetting.weekly.each do |setting|
      site = setting.site
      next if site.feedbacks.last_week.count.zero?
    end
  end

  private
    def channel_factory(channel_name)
      channel_name.constantize.new
    end
end
