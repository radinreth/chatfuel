class AddSessionToTrackings < ActiveRecord::Migration[6.0]
  def change
    add_reference :trackings, :session, null: true, foreign_key: true
  end
end
