require_relative "district.rb"

# site
puts "creating sites"
@districts.each do |district|
  pumi = Pumi::District.find_by_id district[:code]

  if pumi
    Site.create! do |site|
      site.name = pumi.name_latin
      site.code = pumi.id
      site.status = :enable
      site.lat = district[:lat]
      site.lng = district[:lng]
    end
  end
end
