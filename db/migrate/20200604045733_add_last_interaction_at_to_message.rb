class AddLastInteractionAtToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :last_interaction_at, :datetime, default: Time.current
  end
end
