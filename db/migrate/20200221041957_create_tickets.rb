class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :code, null: false, index: true
      t.integer :status, default: 0
      t.date :submitted_at
      t.date :completed_at
      t.date :actual_completed_at
      t.date :picked_up_at

      t.timestamps
    end
  end
end
