class AddSectorToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :sector, :string, default: ""
  end
end
