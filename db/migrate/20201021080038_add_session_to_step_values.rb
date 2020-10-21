class AddSessionToStepValues < ActiveRecord::Migration[6.0]
  def up
    change_column_null :step_values, :message_id, true
    # TODO change null: false
    add_reference :step_values, :session, null: true, foreign_key: true

    ActiveRecord::Base.transaction do
      StepValue.where(session_id: nil).find_each do |step_value|
        step_value.session_id = step_value.message_id
        step_value.save
      end
    end
  end

  def down
    if StepValue.has_attribute?(:message_id)
      change_column_null :step_values, :message_id, false

      ActiveRecord::Base.transaction do
        StepValue.where.not(session_id: nil).find_each do |step_value|
          step_value.message_id = step_value.session_id
          step_value.save
        end
      end
    end

    remove_reference :step_values, :session, null: true, foreign_key: true
  end
end
