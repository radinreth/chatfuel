class UpdateSitesTracksCount < ActiveRecord::Migration[6.0]
  # Update site tracking count
  # base on ticket_code input from bot
  def change
    variable = Variable.find_by(name: "tracking_ticket")
    return unless variable

    sites_count = variable.values.unscope(:order).group("LEFT(raw_value, 4)").count

    Site.find_each do |site|
      site.update tracks_count: sites_count[site.code].to_i
    end
  end
end
