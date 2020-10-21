class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :session_id, null: false
      t.string :session_type, default: ""
      t.string :platform_name, default: ""
      t.integer :status, default: 0
      t.string :district_id
      t.string :province_id
      t.string :gender
      t.datetime :last_interaction_at

      t.timestamps
    end

    Rake::Task["message:migrate_to_session"].invoke
  end
end
