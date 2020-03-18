# frozen_string_literal: true

class SiteSettingsTelegramChatGroup < ApplicationRecord
  belongs_to :site_setting
  belongs_to :telegram_chat_group

  validates :site_setting, :telegram_chat_group, presence: true
end
