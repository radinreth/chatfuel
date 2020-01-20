class CreateVoices < ActiveRecord::Migration[6.0]
  def change
    create_table :voices do |t|
      t.string :call_sid
      t.string :status
      t.string :from
      t.integer :call_duration

      t.timestamps
    end
  end
end
