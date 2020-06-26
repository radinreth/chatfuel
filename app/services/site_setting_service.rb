class SiteSettingService
  attr_reader :site_setting, :variable_value

  def initialize(step_value)
    @variable_value = step_value.variable_value
    @site_setting = step_value.site_setting
  end

  def notify_telegram_group
    return if site_setting.nil? || !site_setting.enable_notification?

    site_setting.telegram_chat_groups.actives.each do |group|
      bot.send_message(chat_id: group.chat_id, text: message, parse_mode: :HTML)
    rescue ::Telegram::Bot::Forbidden => e
      group.update_attributes(is_active: false, reason: e)
    end
  end

  private
    def message
      site_setting.message_template.gsub(/#{SiteSetting::FEEDBACK_MESSAGE}/, "<b>#{variable_value.display_value}</b>")
    end

    def bot
      @bot ||= ::Telegram::Bot::Client.new(TelegramBot.first.token, TelegramBot.first.username)
    end
end
