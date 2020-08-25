# frozen_string_literal: true

module Notification
  class Telegram < ::AlertNotification
    def notify_now(setting_id, message)
      setting = SiteSetting.find(setting_id)

      setting.telegram_chat_groups.actives.each do |group|
        bot(group.bot_token).send_message(chat_id: group.chat_id, text: message, parse_mode: :HTML)
      rescue ::Telegram::Bot::Forbidden => e
        group.update_attributes(is_active: false, reason: e)
      end
    end

    private
      def bot(token)
        ::Telegram::Bot::Client.new(token || current_bot.token)
      end

      def current_bot
        @current_bot ||= TelegramBot.first
      end
  end
end
