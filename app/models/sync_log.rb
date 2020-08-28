# == Schema Information
#
# Table name: sync_logs
#
#  id            :bigint(8)        not null, primary key
#  failure_count :integer(4)       default("0")
#  payload       :hstore           default("")
#  status        :integer(4)
#  success_count :integer(4)       default("0")
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  site_id       :integer(4)
#
class SyncLog < ApplicationRecord
  default_scope { order(created_at: :desc) }

  enum status: %i[failure success]

  belongs_to :site

  before_create :ensure_uuid
  after_commit  :update_site_sync_status, on: [:create, :update]
  after_commit  :upsert_tickets_async, on: [:create, :update]

  validates :status, presence: true

  def upsert_tickets
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

  def sync_status
    success? ? 'connected' : 'disconnected'
  end

  private
    def ensure_uuid
      self.uuid = SecureRandom.uuid
    end

    def upsert_tickets_async
      return if payload.empty?

      SyncLogJob.perform_later(id)
    end

    def update_site_sync_status
      site.update(sync_status: sync_status)
    end
end
