class CreateDictionaries < ActiveRecord::Migration[6.0]
  def change
    create_table :dictionaries do |t|
      t.string :value
      t.string :header

      t.timestamps
    end
  end
end
