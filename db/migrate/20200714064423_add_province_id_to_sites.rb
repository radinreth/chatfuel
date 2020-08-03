class AddProvinceIdToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :province_id, :string

    # Rake::Task['site:migrate_province'].invoke
  end
end
