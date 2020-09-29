# == Schema Information
#
# Table name: trackings
#
#  id                :bigint(8)        not null, primary key
#  site_code         :string
#  status            :integer(4)
#  ticket_code       :string
#  tracking_datetime :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  message_id        :bigint(8)        not null
#
# Indexes
#
#  index_trackings_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
FactoryBot.define do
  factory :tracking do
    status { 1 }
    tracking_datetime { "2020-09-21 07:04:07" }
    message { nil }
  end
end
