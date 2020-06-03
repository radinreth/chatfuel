class ChangeDateInfoForTickets < ActiveRecord::Migration[6.0]
  def change
    remove_column :tickets, :picked_up_at, :date
    remove_column :tickets, :submitted_at, :date
    add_column :tickets, :incomplete_at, :date
    add_column :tickets, :incorrect_at, :date
  end
end
