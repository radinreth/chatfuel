class CreateTextMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :text_messages do |t|
      t.string :messenger_user_id
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :profile_pic_url
      t.string :timezone
      t.string :locale
      t.string :source
      t.string :last_seen
      t.string :signed_up
      t.string :sessions
      t.string :last_visited_block_name
      t.string :last_visited_block_id
      t.string :last_clicked_button_name

      t.timestamps
    end
  end
end
