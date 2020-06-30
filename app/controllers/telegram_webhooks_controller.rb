# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  # call when create group with bot
  def start!
    return if chat["title"].nil?
    group = TelegramChatGroup.find_or_initialize_by(chat_id: chat["id"])
    group.update(title: chat["title"], is_active: true)
  end

  def message(message)
    return unless bot_added?(message)

    group = TelegramChatGroup.find_or_initialize_by(chat_id: chat["id"])
    group.update(title: chat["title"], is_active: true)
  end

  private
    def bot_added?(message)
      new_member = message["new_chat_member"]
      message["group_chat_created"] || new_member.try(:[], "username") == TelegramBot.first.username
    end
end
