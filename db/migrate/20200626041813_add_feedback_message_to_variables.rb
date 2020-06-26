class AddFeedbackMessageToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :feedback_message, :boolean, default: false
  end
end
