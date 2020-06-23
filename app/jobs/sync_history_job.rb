class SyncHistoryJob < ApplicationJob
  queue_as :default

  def perform(site_id, sync_history_uuid)
    site = Site.find(site_id)
    sync_history = SyncHistoryLog.find_by(uuid: sync_history_uuid)

    tickets = sync_history.payload["tickets"]
    parser = JsonParser.new(tickets)

    parser.to_json.values.each do |ticket_attribute|
      ticket = site.tickets.build(ticket_attribute)
      if ticket.save
        sync_history.increment! :success_count
      else
        sync_history.increment! :failure_count
      end
    end
  end
end
