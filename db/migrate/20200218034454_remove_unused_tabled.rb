class RemoveUnusedTabled < ActiveRecord::Migration[6.0]
  def change
    drop_table :activities
    drop_table :leads
    drop_table :answers
    drop_table :identities
    drop_table :voices
    drop_table :voice_answers
    drop_table :dictionaries
  end
end
