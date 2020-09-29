class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.integer :status
      t.string :ticket_code
      t.string :site_code
      t.datetime :tracking_datetime
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end

  rescue => e
    puts e.message
  end
end
