# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  code                :string           not null
#  completed_at        :date
#  picked_up_at        :date
#  status              :integer(4)       default("0")
#  submitted_at        :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_tickets_on_code  (code)
#
RSpec.describe Ticket, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute(:code) }
    it { is_expected.to have_attribute(:status) }
    it { is_expected.to have_attribute(:submitted_at) }
    it { is_expected.to have_attribute(:completed_at) }
    it { is_expected.to have_attribute(:actual_completed_at) }
    it { is_expected.to have_attribute(:picked_up_at) }
  end
  
  describe 'associations' do
    it { is_expected.to have_one(:track) }
    it { is_expected.to have_one(:step) }
    it { is_expected.to have_one(:message) }
  end

  context 'scopes' do
    let(:submitted) { create(:ticket, status: :submitted) }
    let(:completed) { create(:ticket, status: :completed) }
    let(:text_message) { build(:text_message) }
    let(:message) { build(:message, content: text_message) }
    let(:step) { build(:step, message: message) }

    before do
      create(:track, step: step, ticket: submitted)
      create(:track, step: step, ticket: completed)
    end

    it '.count' do
      expect(described_class.count).to eq 2
    end

    it '.completed_with_session' do
      expect(described_class.completed_with_session).to match_array([completed])
    end
  end

  describe 'validations' do
    it { is_expected.to define_enum_for(:status)
      .with_values(%i[submitted completed notified picked_up]) }
  end
end
