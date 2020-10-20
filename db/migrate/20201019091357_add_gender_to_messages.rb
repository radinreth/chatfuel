class AddGenderToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :gender, :string, default: ""
    Rake::Task['step_value:migrate_gender'].invoke
  end
end
