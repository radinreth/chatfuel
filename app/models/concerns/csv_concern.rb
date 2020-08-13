require 'csv'

module CsvConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def to_csv(results, fields)
      CSV.generate do |csv|
        csv << csv_header(fields)

        results.find_each do |result|
          row = []

          row << result.session_id
          row << result.created_at
          row << field_values(result, fields)

          csv << row.flatten
        end
      end
    end

    private

    def csv_header(fields)
      ['session_id', 'created_at'] + fields.pluck(:name)
    end

    def field_values(result, fields)
      list = []

      fields.each do |field|
        result.step_values.most_recent.each do |step_value|
          if field.name == step_value.variable.name
            list << step_value.variable_value.mapping_value
            break
          end
        end
      end

      list
    end
  end
end
