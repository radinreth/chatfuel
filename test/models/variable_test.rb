# == Schema Information
#
# Table name: variables
#
#  id                  :bigint(8)        not null, primary key
#  is_location         :boolean
#  is_most_request     :boolean          default("false")
#  is_service_accessed :boolean          default("false")
#  is_ticket_tracking  :boolean          default("false")
#  is_user_visit       :boolean          default("false")
#  marks_as            :string           is an Array
#  name                :string
#  report_enabled      :boolean          default("false")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_variables_on_marks_as  (marks_as) USING gin
#
require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
