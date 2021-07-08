class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :name, null: false
      t.string :cron, null: false
      t.boolean :enabled, default: false
      t.string :worker, default: ""

      t.timestamps
    end
  end
end
