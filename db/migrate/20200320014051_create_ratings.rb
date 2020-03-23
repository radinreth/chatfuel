class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :feedback, null: false, foreign_key: true
      t.references :variable, null: false, foreign_key: true

      t.timestamps
    end
  end
end
