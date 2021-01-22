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
require 'rails_helper'

RSpec.describe Tracking, type: :model do
  it { is_expected.to define_enum_for(:status).with_values(%i[incorrect incomplete completed]) }
  it { is_expected.to have_attribute(:tracking_datetime) }
  it { is_expected.to belong_to(:session) }
end
