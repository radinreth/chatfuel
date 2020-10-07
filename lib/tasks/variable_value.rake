# frozen_string_literal: true

namespace :variable_value do
  desc 'Migrate step_values_count in variable_values table'
  task migreate_step_values_count: :environment do
    VariableValue.all.find_each do |value|
      VariableValue.reset_counters(value.id, :step_values)
    end
  end

  desc "Remove raw value null from variable value"
  task remove_null_value: :environment do
    null_values = VariableValue.unscoped.where(raw_value: 'null')
    null_values.destroy_all
  end

  desc "Migrate data from raw_value to mapping_value_km"
  task migrate_raw_value_to_mapping_value_km: :environment do
    ActiveRecord::Base.transaction do
      VariableValue.find_each do |variable_value|
        if variable_value.mapping_value_km.blank?
          variable_value.update!(mapping_value_km: variable_value.raw_value)
        end
      end
    end
  end
end
