class AddSessionToStepValues < ActiveRecord::Migration[6.0]
  def up
    change_column_null :step_values, :message_id, true
    # TODO change null: false
    add_reference :step_values, :session, null: true, foreign_key: true
  end

  def down
    change_column_null :step_values, :message_id, false
    remove_reference :step_values, :session, null: true, foreign_key: true
  end
end
