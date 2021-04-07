require "rails_helper"

RSpec.describe Api::V1::SitesController, type: :controller do
  describe "routes" do
    it { should route(:put, "/api/v1/me").to(action: :check, format: :json) }
    it { should route(:patch, "/api/v1/sites/0202").to(action: :update, site_code: "0202", format: :json)  }
    it { should route(:get, "/api/v1/sites/0212/map").to(action: :map, site_code: "0212", format: :json, locale: :km) }
  end

  describe "PUT :check" do
    let!(:site) { create(:site, code: "0202", sync_status: "failure") }

    before do
      request.headers['Authorization'] = "Bearer #{site.token}"

      put :check, params: { site_code: "0202", sync_status: "success" }
    end

    it { expect(JSON.parse(response.body)).to include({ message: site.id, status: "ok" }.as_json) }
    it { expect(site.reload.sync_status).to eq "success" }
  end

  describe "PATCH :update" do
    let(:site) { create(:site, name_en: "kamrieng", code: "0202") }
    let(:params) {
      { site_code: site.code, tickets: [
        { TicketID: '0102-001', Sector: 'អត្រានុកូលដ្ឋាន', Tel: '011 222 333', DistGis: '0102', ServiceDescription: 'សំបុត្តកំណើត', Status: 'Approved', RequestedDate: 1.day.ago,  ApprovalDate: Date.today, DeliveryDate: ''}
      ]}
    }

    before {
      request.headers['Authorization'] = "Bearer #{site.token}"
      patch :update, params: params
    }

    it { expect(response.status).to eq 200 }
  end

  describe "GET :map" do
    let!(:site) { create(:site) }

    it "renders json" do
      get :map, params: { site_code: site.code }

      expect(response.status).to eq 200
    end
  end
end
