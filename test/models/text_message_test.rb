# == Schema Information
#
# Table name: text_messages
#
#  id                :bigint(8)        not null, primary key
#  first_name        :string
#  gender            :string
#  last_name         :string
#  profile_pic_url   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  messenger_user_id :string           not null
#
require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
