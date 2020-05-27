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
RSpec.describe Variable do
  describe 'attributes' do
    it { should have_attribute(:type) }
  end
end
