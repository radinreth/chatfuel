class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :act, null: false
      t.string :value, null: false
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
