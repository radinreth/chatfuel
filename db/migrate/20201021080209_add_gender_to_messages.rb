class AddGenderToMessages < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:messages, :gender)
      add_column :messages, :gender, :string, default: ""
      Message.reset_column_information
    end

    Rake::Task['step_value:migrate_gender_raw_value_to_message'].invoke
    Rake::Task['message:migrate_missing_gender_on_new_session'].invoke
    Rake::Task['session:copy_gender_from_message'].invoke
  end
end
