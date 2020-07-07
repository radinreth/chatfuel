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
#  site_id             :bigint(8)
#
# Indexes
#
#  index_tickets_on_code     (code)
#  index_tickets_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
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
    it { is_expected.to belong_to(:site) }
  end

  context "scopes" do
    let(:recent_message) { build(:message, :text, last_interaction_at: 1.days.ago) }
    let(:recent_step) { build(:step, message: recent_message) }
    let(:recent_ticket) { build(:ticket, :completed) }

    let(:late_message) { build(:message, :text, last_interaction_at: 10.days.ago) }
    let(:late_step) { build(:step, message: late_message) }
    let(:late_ticket) { build(:ticket, :completed) }

    before do
      create(:track, step: recent_step, ticket: recent_ticket)
      create(:track, step: late_step, ticket: late_ticket)
    end

    it ".count" do
      expect(described_class.count).to eq 2
    end

    it ".completed_with_session" do
      expect(described_class.completed_with_session).to match_array([recent_ticket, late_ticket])
    end

    it ".completed_in_time_range" do
      expect(described_class.completed_in_time_range).to match_array([recent_ticket])
    end
  end

  describe "validations" do
    statuses = %i[incomplete completed incorrect notified]

    it { is_expected.to define_enum_for(:status).with_values(statuses) }
  end
end
