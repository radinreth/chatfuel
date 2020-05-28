class MessengerService
  def self.prepare(completed_tickets)
    quota = Quotum.last

    if quota
      interval = 0
      completed_tickets.find_each(batch_size: quota.sentable_size) do |ticket|
        interval += 5
        BroadcastJob.set(wait_until: interval.seconds).perform_later(ticket)
      end
      quota.increment! :total_sent, quota.sentable_size
    end
  end
end
