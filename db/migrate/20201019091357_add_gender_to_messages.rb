class AddGenderToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :gender, :string, default: ""
    Rake::Task['step_value:migrate_gender_raw_value_to_message'].invoke
    Rake::Task['message:migrate_missing_gender_on_new_session'].invoke
  end
end
