class CreateStepValues < ActiveRecord::Migration[6.0]
  def change
    create_table :step_values do |t|
      t.references :step, null: false, foreign_key: true
      t.references :variable_value, null: false, foreign_key: true
    end
  end
end
