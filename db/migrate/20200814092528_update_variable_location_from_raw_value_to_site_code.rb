class UpdateVariableLocationFromRawValueToSiteCode < ActiveRecord::Migration[6.0]
  SITES = { "Krong Battambang": '0203', "Moung Ruessei": '0206', "Thma Koul": '0202', "Bavel": '0204', "Kamrieng": '0212', "others": '0000' }

  def up
    return unless variable

    variable.update(name: 'location')
    # update location from site_name to site_code
    variable.values.each do |value|
      value.update(raw_value: SITES[value.raw_value.to_sym])
    end
  end

  def down
    return unless variable

    variable.update(name: 'location_name')
    # update location from site_code to site_name
    variable.values.each do |value|
      value.update(raw_value: SITES.key(value.raw_value).to_s)
    end
  end

  private

  def variable
    @variable ||= Variable.find_by(is_location: true)
  end
end
