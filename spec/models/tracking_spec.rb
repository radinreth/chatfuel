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
require 'rails_helper'

RSpec.describe Tracking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
