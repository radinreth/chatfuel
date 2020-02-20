class RenameCallSid < ActiveRecord::Migration[6.0]
  def change
    rename_column :voice_messages, :call_id, :callsid
  end
end
