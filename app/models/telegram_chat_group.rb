# == Schema Information
#
# Table name: telegram_chat_groups
#
#  id         :bigint(8)        not null, primary key
#  bot_token  :string
#  chat_type  :string           default("group")
#  is_active  :boolean
#  reason     :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :string
#
class TelegramChatGroup < ApplicationRecord
  has_many :site_settings_telegram_chat_groups
  has_many :site_settings, through: :site_settings_telegram_chat_groups

  scope :actives, -> { where(is_active: true) }

  TELEGRAM_CHAT_TYPES = %w[group supergroup]
  TELEGRAM_SUPER_GROUP = 'supergroup'
  TELEGRAM_GROUP = 'group'

  def self.with_current_actived_bot
    bot = TelegramBot.actived.first

    return [] unless bot.present?

    self.where(bot_token: bot.token)
  end
end
