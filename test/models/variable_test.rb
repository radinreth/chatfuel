# == Schema Information
#
# Table name: variables
#
#  id                  :bigint(8)        not null, primary key
#  is_location         :boolean
#  is_most_request     :boolean          default(FALSE)
#  is_service_accessed :boolean          default(FALSE)
#  is_ticket_tracking  :boolean          default(FALSE)
#  is_user_visit       :boolean          default(FALSE)
#  name                :string
#  report_enabled      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'test_helper'

class VariableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
