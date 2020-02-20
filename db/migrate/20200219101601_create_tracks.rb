class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :code
      t.belongs_to :site
      t.belongs_to :step
      t.timestamps
    end
  end
end
