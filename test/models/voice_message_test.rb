# == Schema Information
#
# Table name: voice_messages
#
#  id          :bigint           not null, primary key
#  callsid     :integer
#  address     :string
#  called_at   :datetime
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#
require 'test_helper'

class VoiceMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
