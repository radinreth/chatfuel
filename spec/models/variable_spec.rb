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
#  name                :string
#  report_enabled      :boolean          default("false")
#  type                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
RSpec.describe Variable do
  describe 'attributes' do
    it { should have_attribute(:type) }
  end
end
