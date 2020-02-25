# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  act        :string           not null
#  value      :string
#  message_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
