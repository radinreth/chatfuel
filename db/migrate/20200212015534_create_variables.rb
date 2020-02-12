class CreateVariables < ActiveRecord::Migration[6.0]
  def change
    create_table :variables do |t|
      t.string :type, null: false
      t.string :name
      t.string :value
      t.string :text

      t.timestamps
    end

    add_index :variables, [:type, :name], unique: true
  end
end
