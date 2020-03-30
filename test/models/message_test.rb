# == Schema Information
#
# Table name: messages
#
#  id           :bigint(8)        not null, primary key
#  content_type :string
#  status       :integer(4)       default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_id   :integer(4)
#
# Indexes
#
#  index_messages_on_content_type_and_content_id  (content_type,content_id)
#
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
