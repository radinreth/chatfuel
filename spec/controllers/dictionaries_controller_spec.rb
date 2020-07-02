require "rails_helper"

RSpec.describe DictionariesController, type: :controller do

  describe "routes" do
    it { should route(:get, "/dictionaries").to(action: :index) }
    it { should route(:patch, "/dictionaries/1").to(action: :update, id: 1) }
  end

  describe "GET #index" do
    context "system admin" do
      setup_system_admin

      it "returns http success" do
        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context "site admin" do
      setup_site_admin

      xit "is not authorize" do
        get :index

        expect(response).to have_http_status(:found)
      end
    end

    context "site_ombudsman" do
      setup_site_ombudsman

      xit "is not authorize" do
        get :index

        expect(response).to have_http_status(:found)
      end
    end
  end

end
