require "rails_helper"

RSpec.describe Api::V1::SyncLogsController, type: :controller do
  describe "routes" do
    it { should route(:post, "/api/v1/syncs").to(action: :create, format: :json) }
    it { should route(:patch, "/api/v1/syncs/1").to(action: :update, id: "1", format: :json)  }
  end

  describe "POST :create" do
    let!(:site)    { create(:site, code: "0202" ) }
    let(:sync_log) { site.sync_logs.last }

    before do
      request.headers['Authorization'] = "Bearer #{site.token}"

      post :create, params: { status: "success" }
    end

    it { expect(JSON.parse(response.body)).to include(sync_log.as_json) }
    it { expect(site.sync_logs.count).to eq(1) }
    it { expect(sync_log.status).to eq('success') }
  end

  describe "PUT :update" do
    let(:site) { create(:site, name_en: "kamrieng", code: "0202") }
    let(:sync_log) { site.sync_logs.create(status: 'success') }
    let(:params) {
      {
        id: sync_log.id,
        tickets: [
          { TicketID: '0102-001', Tel: '011 222 333', DistGis: '0102', ServiceDescription: 'សំបុត្តកំណើត', Status: 'Approved', RequestedDate: 1.day.ago,  ApprovalDate: Date.today, DeliveryDate: ''}
        ]
      }
    }

    before {
      request.headers['Authorization'] = "Bearer #{site.token}"
      put :update, params: params
    }

    it { expect(response.status).to eq 200 }
    it { expect(sync_log.reload.payload).not_to be_empty }
  end
end
