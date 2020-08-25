class AddSessionToStepValues < ActiveRecord::Migration[6.0]
  def change
    # TODO change null: false
    add_reference :step_values, :session, null: true, foreign_key: true
  end
end
