# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def message(message)
    return create_new_group if message['group_chat_created'].present?
    return migrate_chat_group(message) if message['migrate_to_chat_id'].present?
    return unless managing_member?(message)

    group = TelegramChatGroup.find_or_initialize_by(chat_id: message['chat']["id"].to_s)
    group.update(bot_params(message, group))
  end

  private
    def create_new_group
      group = TelegramChatGroup.find_or_initialize_by(chat_id: chat["id"])
      group.update(
        title: chat["title"],
        is_active: true,
        chat_type: chat["type"],
        bot_token: TelegramBot.actived.first.try(:token)
      )
    end

    def managing_member?(message)
      member = message['left_chat_member'] || message['new_chat_member']
      member.present? && member['is_bot'] && TelegramChatGroup::TELEGRAM_CHAT_TYPES.include?(message['chat']['type'])
    end

    def migrate_chat_group(message)
      group = TelegramChatGroup.find_by(chat_id: message['chat']['id'].to_s).presence
      group.update(chat_id: message['migrate_to_chat_id'], chat_type: TelegramChatGroup::TELEGRAM_SUPER_GROUP)
    end

    def bot_params(message, group)
      {
        title: message['chat']['title'],
        is_active: message['new_chat_member'].present?,
        chat_type: message['chat']['type'],
        bot_token: group.bot_token || TelegramBot.actived.first.try(:token)
      }
    end
end
