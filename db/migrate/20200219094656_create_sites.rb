class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name, null: false, index: true
      t.integer :code, default: 0

      t.timestamps
    end
  end
end
