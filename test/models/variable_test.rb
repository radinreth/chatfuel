# == Schema Information
#
# Table name: variables
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  report_enabled :boolean          default("false")
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
