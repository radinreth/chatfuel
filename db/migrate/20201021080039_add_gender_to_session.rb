class AddGenderToSession < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:sessions, :gender)
      add_column :sessions, :gender, :string, default: ""
    end

    Session.reset_column_information
    ActiveRecord::Base.connection.execute("
      UPDATE sessions
        SET gender = messages.gender
        FROM messages
        WHERE sessions.gender IS NULL AND
              sessions.id = messages.id; ");
  end
end
