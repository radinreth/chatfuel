class AddFeedbackLocationCodeToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :feedback_location_code, :string, limit: 4
  end
end
