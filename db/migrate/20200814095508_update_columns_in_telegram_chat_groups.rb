class UpdateColumnsInTelegramChatGroups < ActiveRecord::Migration[6.0]
  def change
    change_column :telegram_chat_groups, :chat_id, :string
    add_column    :telegram_chat_groups, :chat_type, :string, default: 'group'
    add_column    :telegram_chat_groups, :bot_token, :string
  end
end
