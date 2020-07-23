class RemoveFeedbackMessageFromVariable < ActiveRecord::Migration[6.0]
  def change
    remove_column :variables, :feedback_message
  end
end
