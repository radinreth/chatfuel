# users
role_ids = Role.ids
site_ids = Site.ids
site_codes = Site.all.map(&:code)

puts "creating users"
10.times.each do |i|
  user = User.new do |u|
    u.email = FFaker::Internet.email
    u.actived = true
    u.password = FFaker::Internet.password
    u.role_id = role_ids.sample
    u.site_id = site_ids.sample
  end

  unless user.save
    puts user.inspect
  end
end
