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
FactoryBot.define do
  factory :sync_history_log do
    payload { "" }
    success_count { 0 }
    failure_count { 0 }
    site
  end
end
