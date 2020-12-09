class ChangeMessageLastInteractionAtDatetimeDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :last_interaction_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }

    Rake::Task["message:migrate_last_interaction_at"].invoke
  end
end
