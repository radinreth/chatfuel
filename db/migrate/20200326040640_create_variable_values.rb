class CreateVariableValues < ActiveRecord::Migration[6.0]
  def change
    create_table :variable_values do |t|
      t.string :raw_value, null: false
      t.string :mapping_value, default: ""
      t.integer :status, default: 0
      t.references :variable, null: false, foreign_key: true

      t.timestamps
    end

    # migrate
    hash = {}

    Variable.where.not(value: nil).each do |var|
      found = hash[var.name]

      if found.present?
        value = VariableValue.new( raw_value: var.value, mapping_value: var.text, status: var.status )
        value.variable_id = found
        value.save
      else
        VariableValue.create do |vv|
          vv.raw_value= var.value
          vv.mapping_value= var.text
          vv.status= var.status
          vv.variable_id = var.id
        end

        hash[var.name] = var.id
      end
    end
  end
end
