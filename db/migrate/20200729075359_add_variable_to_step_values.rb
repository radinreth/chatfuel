class AddVariableToStepValues < ActiveRecord::Migration[6.0]
  def change
    add_reference :step_values, :variable, null: false, foreign_key: true
  end
end
