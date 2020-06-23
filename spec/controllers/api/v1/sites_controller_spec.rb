require "rails_helper"

RSpec.describe Api::V1::SitesController, type: :controller do
  describe "routes" do
    it { should route(:put, "/api/v1/me").to(action: :check, format: :json) }
    it { should route(:patch, "/api/v1/sites/0202").to(action: :update, site_code: "0202", format: :json)  }
  end

  describe "PUT :check" do
    let(:site) { create(:site, code: "0202", sync_status: "failure") }

    before do
      site.generate_token
      request.headers['Authorization'] = "Bearer #{site.token}"
    end

    it "updates site :sync_status" do
      expected = { message: site.id, status: "ok" }
      put :check, params: { site_code: "0202", sync_status: "success" }

      expect(JSON.parse(response.body)).to include(expected.as_json)
      expect(site.reload.sync_status).to eq "success"
    end
  end

  describe "PATCH :update" do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }

    it "success" do
      request.headers['Authorization'] = "Bearer #{site.token}"
      patch :update, params: { site_code: site.code }

      expect(response.status).to eq 200
    end

    context "site not found" do

      before do
        site
      end

      it "response not found" do
        patch :update, params: { site_code: "0000" }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expected = {
          errors: [{
            field: "code", 
            message: "Not found", 
            resource: "Site" }], 
          message: "Bad Request" }.as_json
        expect(JSON.parse(response.body)).to include(expected)
      end
    end

    context "token" do
      
      before do
        site.generate_token

        request.headers['Authorization'] = "Bearer #{site.token}"
      end

      it "invalid token" do
        site.generate_token
        patch :update, params: { site_code: site.code, site: { status: "enable", sync_status: "success" } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to include("application/json")
        
        expected = {
          errors: [{
            field: "token", 
            message: "Not match", 
            resource: "Site" }], 
          message: "Bad Request" }
        expect(JSON.parse(response.body)).to include(expected.as_json)
      end

      it "valid token" do
        expected = { name: "kamrieng", sync_status: "success" }
        patch :update, params: { site_code: site.code, site: { sync_status: "success" } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")
        
        expect(JSON.parse(response.body)).to include(expected.as_json)
      end
    end
  end
end
