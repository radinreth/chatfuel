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
#
# Indexes
#
#  index_sync_history_logs_on_uuid  (uuid)
#
class SyncHistoryLog < ApplicationRecord
  before_create :ensure_uuid

  private
    def ensure_uuid
      self.uuid = SecureRandom.uuid
    end
end
