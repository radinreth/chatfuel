# == Schema Information
#
# Table name: steps
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint(8)        not null
#
# Indexes
#
#  index_steps_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
require "rails_helper"

RSpec.describe Step do
  describe "validations" do
    let(:text_message) { create(:text_message) }
    let(:message) { create(:message, content: text_message) }

    before { create(:step, :accessed) }

    it ".accessed" do
      expect(described_class.accessed.count).to eq 1
      expect(described_class.accessed).to all(be_a(described_class)) 
    end
  end

  describe "associations" do
    it { should belong_to(:message) }
  end
end
