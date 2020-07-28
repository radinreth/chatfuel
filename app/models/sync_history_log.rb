# == Schema Information
#
# Table name: sync_history_logs
#
#  id            :bigint(8)        not null, primary key
#  failure_count :integer(4)       default("0")
#  payload       :hstore           default(""), not null
#  success_count :integer(4)       default("0")
#  uuid          :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  site_id       :integer(4)
#
# Indexes
#
#  index_sync_history_logs_on_uuid  (uuid)
#
class SyncHistoryLog < ApplicationRecord
  belongs_to :site

  before_create :ensure_uuid
  after_commit  :upsert_tickets_to_site_async, on: :create

  def upsert_tickets_to_site
    ticket_attrs = TicketParser.new(payload["tickets"]).to_json
    ticket_attrs.each do |ticket_attr|
      ticket = site.tickets.find_or_initialize_by(code: ticket_attr[:code])

      if ticket.update(ticket_attr)
        increment! :success_count
      else
        increment! :failure_count
      end
    end
  end

  private
    def ensure_uuid
      self.uuid = SecureRandom.uuid
    end

    def upsert_tickets_to_site_async
      SyncHistoryJob.perform_later(id)
    end

    # accepted paid => incomplete
    # approved rejected delivered = completed

    # move to call back 
    # x after changes from accepted -> approved
    # x current status is completed
    # x last interact within 7 days
    #   > update to notified
    #   > reuse :completed template if exist
    #   > response based on type of those who has tracked

    # xafter sync
    #   challenge1: use async when don't know when it will be finish
    # xcollection: completed
end
