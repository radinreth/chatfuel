class AddReportEnabledToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :report_enabled, :boolean, default: false
  end
end
