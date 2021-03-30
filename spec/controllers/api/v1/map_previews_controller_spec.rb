require "rails_helper"

RSpec.describe Api::V1::MapPreviewsController, type: :controller do
  describe "routes" do
    it { should route(:get, "/api/v1/map_preview").to(action: :show, format: :json, locale: "km") }
  end

  describe "actions" do
    describe "GET :show" do
      let!(:site) { create(:site) }

      it "renders json" do
        get :show, params: { district: site.code }

        expect(response.status).to eq 200
      end
    end
  end
end
