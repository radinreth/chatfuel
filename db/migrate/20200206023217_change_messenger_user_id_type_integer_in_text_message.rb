class ChangeMessengerUserIdTypeIntegerInTextMessage < ActiveRecord::Migration[6.0]
  def change
    change_column :text_messages, :messenger_user_id, "bigint USING CAST(messenger_user_id as bigint)"
  end
end
