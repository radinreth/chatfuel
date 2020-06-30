# frozen_string_literal: true

class CreateJoinTableSiteSettingTelegramChatGroup < ActiveRecord::Migration[6.0]
  def change
    create_join_table :site_settings, :telegram_chat_groups do |t|
      t.integer :id, primary_key: true
    end
  end
end
