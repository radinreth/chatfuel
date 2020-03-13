require "rails_helper"

RSpec.describe UsersController, type: :controller do
  setup_system_admin

  context "html" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "json" do
    describe "GET :index" do
      it "returns json" do
        get :index, format: :json

        expect(response.headers["Content-Type"]).to include("application/json")
        expect(response.body).to include("ombudsman", "site_admin", "system_admin")
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
