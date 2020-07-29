class UpdateColumnInSettings < ActiveRecord::Migration[6.0]
  def up
    remove_column :settings, :incompleted_text
    remove_column :settings, :completed_text

    add_column :settings, :var, :string, null: false
    add_column :settings, :value, :text, null: true

    add_index :settings, %i(var), unique: true
  end

  def down
    add_column :settings, :incompleted_text, :text
    add_column :settings, :completed_text, :text

    remove_column :settings, :var
    remove_column :settings, :value

    remove_index :settings, name: "index_settings_on_var"
  end
end
