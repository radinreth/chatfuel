class SyncHistoryJob < ApplicationJob
  queue_as :default

  def perform(sync_history_uuid)
    sync_history = SyncHistoryLog.find_by(uuid: sync_history_uuid)

    tickets_attributes = sync_history.payload["tickets_attributes"]
    parser = JsonParser.new(tickets_attributes)

    parser.to_json.values.each do |ticket_attribute|
      ticket = Ticket.new(ticket_attribute)
      if ticket.save
        sync_history.increment! :success_count
      else
        sync_history.increment! :failure_count
      end
    end
  end
end
