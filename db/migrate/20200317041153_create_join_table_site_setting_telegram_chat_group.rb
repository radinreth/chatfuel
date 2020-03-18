# frozen_string_literal: true

class CreateJoinTableSiteSettingTelegramChatGroup < ActiveRecord::Migration[6.0]
  def change
    create_join_table :site_settings, :telegram_chat_groups do |t|
      # t.index [:site_setting_id, :telegram_chat_group_id]
      # t.index [:telegram_chat_group_id, :site_setting_id]
    end
  end
end
