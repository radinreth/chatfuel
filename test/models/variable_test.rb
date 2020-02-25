# == Schema Information
#
# Table name: variables
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  name       :string
#  value      :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
