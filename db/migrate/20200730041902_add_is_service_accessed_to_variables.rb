class AddIsServiceAccessedToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :is_service_accessed, :boolean, default: false
  end
end
