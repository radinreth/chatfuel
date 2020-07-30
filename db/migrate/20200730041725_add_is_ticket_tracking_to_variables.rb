class AddIsTicketTrackingToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :is_ticket_tracking, :boolean, default: false
  end
end
