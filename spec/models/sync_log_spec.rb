# == Schema Information
#
# Table name: sync_logs
#
#  id            :bigint(8)        not null, primary key
#  failure_count :integer(4)       default("0")
#  payload       :hstore           default("")
#  status        :integer(4)
#  success_count :integer(4)       default("0")
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  site_id       :integer(4)
#
require 'rails_helper'

RSpec.describe SyncLog, type: :model do
  it { is_expected.to have_attribute(:failure_count) }
  it { is_expected.to have_attribute(:success_count) }
  it { is_expected.to have_attribute(:uuid) }
  it { is_expected.to have_attribute(:payload) }
  it { is_expected.to have_attribute(:site_id) }
  it { is_expected.to have_attribute(:status) }

  it { is_expected.to validate_presence_of(:status) }

  describe "#uuid" do
    let(:sync) { build(:sync_log) }

    it "ensures empty" do
      expect(sync.uuid).to be_nil
    end

    it "ensures present" do
      sync.save

      expect(sync.uuid).to be_present
    end
  end

  describe 'after_commit for create or update, upsert_tickets_async' do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }

    let(:payload) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"\"}]"} }
    let(:sync_log) { SyncLog.new(site_id: site.id, status: 'success', payload: payload) }

    let(:payload2) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"2020-07-23\"}]"} }
    let(:sync_log2) { create(:sync_log, site_id: site.id, status: 'success') }

    it { expect{ sync_log.save }.to have_enqueued_job(SyncLogJob) }
    it { expect{ sync_log2.update(payload: payload2) }.to have_enqueued_job(SyncLogJob) }
  end

  describe '#upsert_tickets' do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }
    let(:payload) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"\"}]"} }
    let(:sync_log) { SyncLog.create(site_id: site.id, payload: payload) }

    before {
      sync_log.upsert_tickets
    }

    context 'insert' do
      it { expect(site.tickets.count).to eq(1) }
      it { expect(site.tickets.first.delivery_date).to be_nil }
    end

    context 'update' do
      let(:payload2) { {"tickets"=>"[{\"TicketID\"=>\"0102-001\", \"Tel\"=>\"011 222 333\", \"DistGis\"=>\"0212\", \"ServiceDescription\"=>\"សំបុត្តកំណើត\", \"Status\"=>\"Approved\", \"RequestedDate\"=>\"2020-07-21 16:45:10 +0700\", \"ApprovalDate\"=>\"2020-07-22\", \"DeliveryDate\"=>\"2020-07-22\"}]"} }
      let(:sync_log2) { SyncLog.create(site_id: site.id, payload: payload2) }

      before {
        sync_log2.upsert_tickets
      }

      it { expect(site.tickets.count).to eq(1) }
      it { expect(site.tickets.first.delivery_date).not_to be_nil }
    end
  end

  describe 'after_create, update site sync_status' do
    let!(:site) { create(:site, name: "kamrieng", code: "0202", sync_status: '') }
    let!(:sync_log) { create(:sync_log, site: site, status: 'success') }

    it { expect(site.reload.sync_status).to eq('connect') }
  end
end
