class AddGenderToSession < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:sessions, :gender)
      add_column :sessions, :gender, :string, default: ""
    end
  end
end
