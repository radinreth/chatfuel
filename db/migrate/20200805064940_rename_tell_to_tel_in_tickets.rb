class RenameTellToTelInTickets < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :tell, :tel
  end
end
