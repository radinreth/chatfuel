class RemoveMessageFromTrackings < ActiveRecord::Migration[6.0]
  def up
    Rake::Task["tracking:migrate_message_to_session"].invoke

    remove_column :trackings, :message_id
  end

  def down
    add_column :trackings, :message_id, :bigint
    add_index :trackings, :message_id

    Rake::Task["tracking:reverse_migrate_message_to_session"].invoke
  end
end
