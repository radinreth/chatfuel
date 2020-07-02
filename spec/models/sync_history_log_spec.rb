# == Schema Information
#
# Table name: sync_history_logs
#
#  id            :bigint(8)        not null, primary key
#  failure_count :integer(4)       default("0")
#  payload       :hstore           default(""), not null
#  success_count :integer(4)       default("0")
#  uuid          :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_sync_history_logs_on_uuid  (uuid)
#
require 'rails_helper'

RSpec.describe SyncHistoryLog, type: :model do
  it { is_expected.to have_attribute(:failure_count) }
  it { is_expected.to have_attribute(:success_count) }
  it { is_expected.to have_attribute(:uuid) }
  it { is_expected.to have_attribute(:payload) }

  describe "#uuid" do
    let(:sync_history) { build(:sync_history_log) }

    it "ensures empty" do
      expect(sync_history.uuid).to be_empty
    end

    it "ensures present" do
      sync_history.save

      expect(sync_history.uuid).to be_present
    end
  end
end
