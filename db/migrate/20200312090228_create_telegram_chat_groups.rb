# frozen_string_literal: true

class CreateTelegramChatGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :telegram_chat_groups do |t|
      t.string :title
      t.integer :chat_id
      t.boolean :is_active
      t.text :reason

      t.timestamps
    end
  end
end
