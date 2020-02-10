class AddFieldsToVideoMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :voice_messages, :project_id, :integer
  end
end
