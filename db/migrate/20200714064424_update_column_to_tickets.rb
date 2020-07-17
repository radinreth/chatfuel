class UpdateColumnToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :tell, :string
    add_column :tickets, :service_description, :string
    add_column :tickets, :dist_gis, :string
    add_column :tickets, :requested_date, :datetime
    add_column :tickets, :approval_date, :datetime
    add_column :tickets, :delivery_date, :datetime
    change_column :tickets, :status, :string, default: nil
  end
end
