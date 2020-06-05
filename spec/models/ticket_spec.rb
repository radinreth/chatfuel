# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  code                :string           not null
#  completed_at        :date
#  incomplete_at       :date
#  incorrect_at        :date
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_tickets_on_code  (code)
#
require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "attributes" do
    it { is_expected.to have_attribute(:code) }
    it { is_expected.to have_attribute(:status) }
    it { is_expected.to have_attribute(:incomplete_at) }
    it { is_expected.to have_attribute(:completed_at) }
    it { is_expected.to have_attribute(:actual_completed_at) }
    it { is_expected.to have_attribute(:incorrect_at) }
  end

  describe "associations" do
    it { is_expected.to have_one(:track) }
    it { is_expected.to have_one(:step) }
    it { is_expected.to have_one(:message) }
  end

  context "scopes" do
    let(:incomplete) { create(:ticket, status: :incomplete) }
    let(:completed) { create(:ticket, status: :completed) }

    let(:text_message) { build(:text_message) }
    let(:message) { build(:message, content: text_message) }
    let(:step) { build(:step, message: message) }

    before do
      create(:track, step: step, ticket: incomplete)
      create(:track, step: step, ticket: completed)
    end

    it ".count" do
      expect(described_class.count).to eq 2
    end

    it ".completed_with_session" do
      expect(described_class.completed_with_session).to match_array([completed])
    end
  end

  describe "validations" do
    statuses = %i[incomplete completed incorrect notified]

    it { is_expected.to define_enum_for(:status).with_values(statuses) }
  end
end
