class RemoveUnusedColsFromTextMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :text_messages, :last_clicked_button_name, :string
    remove_column :text_messages, :last_seen, :string
    remove_column :text_messages, :last_visited_block_name, :string
    remove_column :text_messages, :locale, :string
    remove_column :text_messages, :sessions, :string
    remove_column :text_messages, :signed_up, :string
    remove_column :text_messages, :source, :string
    remove_column :text_messages, :timezone, :string
    remove_column :text_messages, :last_visited_block_id, :string
  end
end
