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
FactoryBot.define do
  factory :sync_log do
    payload { "" }
    success_count { 0 }
    failure_count { 0 }
    site
  end
end
