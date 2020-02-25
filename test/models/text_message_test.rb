# == Schema Information
#
# Table name: text_messages
#
#  id                       :bigint           not null, primary key
#  messenger_user_id        :bigint
#  first_name               :string
#  last_name                :string
#  gender                   :string
#  profile_pic_url          :string
#  timezone                 :string
#  locale                   :string
#  source                   :string
#  last_seen                :string
#  signed_up                :string
#  sessions                 :string
#  last_visited_block_name  :string
#  last_visited_block_id    :string
#  last_clicked_button_name :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
