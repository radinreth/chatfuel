class RemoveColumnsFromSteps < ActiveRecord::Migration[6.0]
  def change
    remove_column :steps, :act, :string
    remove_column :steps, :value, :string
  end
end
