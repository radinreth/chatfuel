require "rails_helper"

RSpec.describe Api::V1::SitesController, type: :controller do
  describe "routes" do
    it { should route(:patch, "/api/v1/sites/0202").to(action: :update, code: "0202", format: "json")  }
  end

  describe "PATCH :update" do
    let(:site) { create(:site, name: "kamrieng", code: "0202") }

    context "site not found" do

      before do
        site
      end

      it "response not found" do
        patch :update, params: { code: "0000" }

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
        patch :update, params: { code: site.code, site: { status: "enable", sync_status: "success" } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to include("application/json")
        
        expected = {
          errors: [{
            field: "token", 
            message: "Token is not matched", 
            resource: "Site" }], 
          message: "Bad Request" }
        expect(JSON.parse(response.body)).to include(expected.as_json)
      end

      it "valid token" do
        expected = { name: "kamrieng", status: "enable", sync_status: "success" }
        patch :update, params: { code: site.code, site: { status: "enable", sync_status: "success" } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")
        
        expect(JSON.parse(response.body)).to include(expected.as_json)
      end
    end
  end
end
