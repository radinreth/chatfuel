# ticket
statuses = Ticket.statuses.keys
site_ids = Site.ids

puts "creating tickets"
10.times.each do |i|
  Ticket.create! do |t|
    site_id = site_ids.sample

    t.code = "#{site_id}#{FFaker::Code.ean[0...8]}"
    t.status = statuses.sample
    t.site_id = site_id
    t.updated_at = (0...6).to_a.sample.days.ago
  end
end
