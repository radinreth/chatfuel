# == Schema Information
#
# Table name: answers
#
#  id            :bigint(8)        not null, primary key
#  mapping_value_en :string           default("")
#  raw_value     :string           default("")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
