class AddNameKmToSites < ActiveRecord::Migration[6.0]
  def up
    rename_column :sites, :name, :name_en
    add_column :sites, :name_km, :string

    Site.find_each do |site|
      distict = Pumi::District.find_by_id(site.code)
      if distict.present?
        site.update(name_km: distict.name_km)
      end
    end
  end

  def down
    remove_column :sites, :name_km
    rename_column :sites, :name_en, :name
  end
end
