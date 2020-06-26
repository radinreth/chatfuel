class AddSiteIdAndFeedbackMessageToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :feedback_message, :boolean, default: false
    add_column :variables, :site_id, :integer
  end
end
