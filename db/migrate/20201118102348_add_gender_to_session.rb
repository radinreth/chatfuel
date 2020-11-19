class AddGenderToSession < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :gender, :string, default: ""
  end
end
