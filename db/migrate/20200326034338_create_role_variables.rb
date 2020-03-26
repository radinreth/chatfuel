class CreateRoleVariables < ActiveRecord::Migration[6.0]
  def change
    create_table :role_variables do |t|
      t.references :role, null: false, foreign_key: true
      t.references :variable, null: false, foreign_key: true

      t.timestamps
    end
  end
end
