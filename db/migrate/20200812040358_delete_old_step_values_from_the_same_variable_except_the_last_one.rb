class DeleteOldStepValuesFromTheSameVariableExceptTheLastOne < ActiveRecord::Migration[6.0]
  def change
    Message.find_each do |message|
      latest_ids = message.step_values.most_recent.map(&:id)
      pp "- remove step values: #{latest_ids} from message: ##{message.id}"
      old_step_values = message.step_values.where.not(id: latest_ids)
      old_step_values.destroy_all
    end
  end
end
