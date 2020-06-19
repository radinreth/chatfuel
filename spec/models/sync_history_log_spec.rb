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
require 'rails_helper'

RSpec.describe SyncHistoryLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
