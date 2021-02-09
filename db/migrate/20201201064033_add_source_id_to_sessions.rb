class AddSourceIdToSessions < ActiveRecord::Migration[6.0]
  def up
    add_column :sessions, :source_id, :string
    
    Session.reset_column_information
    Rake::Task["session:copy_session_id_to_source_id"].invoke

    change_column :sessions, :source_id, :string, null: false
  end

  def down
    remove_column :sessions, :source_id
  end
end
