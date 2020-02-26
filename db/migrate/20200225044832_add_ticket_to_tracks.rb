class AddTicketToTracks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tracks, :ticket
  end
end
