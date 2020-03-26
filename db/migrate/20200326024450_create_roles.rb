class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false

      t.timestamps
    end

    roles = [
      { name: "system admin" },
      { name: "site admin" },
      { name: "site ombudsman" }
    ]
    Role.create(roles)
  end
end
