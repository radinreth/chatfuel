# == Schema Information
#
# Table name: variables
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  status     :integer(4)       default("0")
#  text       :string
#  type       :string           not null
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_variables_on_type_and_name_and_value  (type,name,value) UNIQUE
#
require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
