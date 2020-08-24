# frozen_string_literal: true

module Notification
  class Telegram < ::AlertNotification
    def notify_now(setting_id, message)
      setting = SiteSetting.find(setting_id)

      setting.telegram_chat_groups.actives.with_current_actived_bot.each do |group|
        bot.send_message(chat_id: group.chat_id, text: message, parse_mode: :HTML)
      rescue ::Telegram::Bot::Forbidden => e
        group.update_attributes(is_active: false, reason: e)
      end
    end

    private
      def bot
        @bot ||= ::Telegram::Bot::Client.new(bot_auth_token.token)
      end

      def bot_auth_token
        @bot_auth_token ||= TelegramBot.first
      end
  end
end
