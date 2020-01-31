class CreateVoiceMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :voice_messages do |t|
      t.integer :call_id
      t.string :address
      t.datetime :called_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
