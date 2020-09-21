# == Schema Information
#
# Table name: trackings
#
#  id                :bigint(8)        not null, primary key
#  status            :integer(4)
#  tracking_datetime :datetime
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
