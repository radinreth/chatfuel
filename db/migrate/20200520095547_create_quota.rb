class CreateQuota < ActiveRecord::Migration[6.0]
  def change
    create_table :quota do |t|
      t.string :platform_name, default: "messenger"
      t.integer :threshold, default: 0
      t.float :secure_zone, default: 0.75
      t.string :on_reach_threshold, default: "delay"

      t.timestamps
    end
  end
end
