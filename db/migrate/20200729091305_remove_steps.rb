class RemoveSteps < ActiveRecord::Migration[6.0]
  def up
    remove_index :step_values, :step_id
    remove_column :step_values, :step_id

    drop_table :steps
  end

  def down
    add_column :step_values, :step_id, :integer, null: false
    add_index :step_values, :step_id, using: :btree

    create_table :steps do |t|
      t.string :act, null: false
      t.string :value
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
