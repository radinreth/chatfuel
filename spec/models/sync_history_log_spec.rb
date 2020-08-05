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
#  site_id       :integer(4)
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
  it { is_expected.to have_attribute(:site_id) }

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

  describe 'after_commit for create, upsert_tickets_to_site_async' do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }
    let(:payload) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"\"}]"} }
    let(:sync_history_log) { SyncHistoryLog.new(site_id: site.id, payload: payload) }

    it { expect{ sync_history_log.save }.to have_enqueued_job(SyncHistoryJob) }
  end

  describe '#upsert_tickets_to_site' do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }
    let(:payload) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"\"}]"} }
    let(:sync_history_log) { SyncHistoryLog.create(site_id: site.id, payload: payload) }

    before {
      sync_history_log.upsert_tickets_to_site
    }

    context 'insert' do
      it { expect(site.tickets.count).to eq(1) }
      it { expect(site.tickets.first.delivery_date).to be_nil }
    end

    context 'update' do
      let(:payload2) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"2020-07-22\"}]"} }
      let(:sync_history_log2) { SyncHistoryLog.create(site_id: site.id, payload: payload2) }

      before {
        sync_history_log2.upsert_tickets_to_site
      }

      it { expect(site.tickets.count).to eq(1) }
      it { expect(site.tickets.first.delivery_date).not_to be_nil }
    end
  end
end
