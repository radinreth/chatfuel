class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]

      t.timestamps
    end
  end
end
