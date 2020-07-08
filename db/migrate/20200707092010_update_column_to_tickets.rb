class UpdateColumnToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :service_description, :datetime
    add_column :tickets, :tell, :string
    add_column :tickets, :name, :string
    add_column :tickets, :vill_gis, :string
    add_column :tickets, :requested_date, :datetime
    add_column :tickets, :accepted_date, :datetime
    add_column :tickets, :approved_date, :datetime
    add_column :tickets, :delivery_date, :datetime
  end
end
