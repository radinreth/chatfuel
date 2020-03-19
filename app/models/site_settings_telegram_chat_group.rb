# frozen_string_literal: true

# == Schema Information
#
# Table name: site_settings_telegram_chat_groups
#
#  id                     :integer(4)       not null, primary key
#  site_setting_id        :bigint(8)        not null
#  telegram_chat_group_id :bigint(8)        not null
#
class SiteSettingsTelegramChatGroup < ApplicationRecord
  belongs_to :site_setting
  belongs_to :telegram_chat_group

  validates :site_setting, :telegram_chat_group, presence: true
  validates_uniqueness_of :site_setting_id, scope: :telegram_chat_group_id
end
