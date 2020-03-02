class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name, null: false, index: true
      t.string :code, default: '', unique: true
      t.integer :tracks_count, default: 0

      t.timestamps
    end
  end
end
