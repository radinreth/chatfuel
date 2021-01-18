require "rails_helper"

RSpec.describe Api::V1::SocialSharesController do
  context "WITH invalid TOKEN" do
    before do
      request.headers["Authorization"] = "Token token=123"
    end

    it "does not allow user to pass" do
      post :create, params: { "social_share": { site_name: "facebook" } }

      expect(response).to be_unauthorized
    end
  end

  context "WITH valid TOKEN" do
    before do
      request.session["_csrf_token"] = "abc123"
      request.headers["Authorization"] = "Token token=abc123"
    end

    it "allows user to pass" do
      post :create, params: { "social_share": { site_name: "facebook" } }

      expect(response).to be_successful
    end
  end
end
