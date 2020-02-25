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
RSpec.describe Step do
  describe 'validations' do
    let(:text_message) { create(:text_message) }
    let(:message) { create(:message, content: text_message) }

    before { create(:step, message_id: message.id) }

    it { should validate_uniqueness_of(:act).scoped_to(:message_id) }
  end

  describe 'associations' do
    it { should belong_to(:message) }
  end
end
