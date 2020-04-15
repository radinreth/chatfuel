class ChangeMessageUserIdDataType < ActiveRecord::Migration[6.0]
  def change
    change_column :text_messages, :messenger_user_id, :string, null: false
  end
end
