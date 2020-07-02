class AddSiteIdToTickets < ActiveRecord::Migration[6.0]
  def change
    add_reference :tickets, :site, null: false, foreign_key: true
  end
end
