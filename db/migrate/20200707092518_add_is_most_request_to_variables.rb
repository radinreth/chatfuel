class AddIsMostRequestToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :is_most_request, :boolean, default: false
    add_column :variables, :is_user_visit, :boolean, default: false
  end
end
