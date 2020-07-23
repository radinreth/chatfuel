class AddIsLocationToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :is_location, :boolean
  end
end
