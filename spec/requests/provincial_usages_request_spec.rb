require 'rails_helper'

RSpec.describe "ProvincialUsages", type: :request do
  describe "GET /index" do
    login_system_admin

    it "returns http success" do
      get "/provincial-usages"
      expect(response).to have_http_status(:success)
    end
  end

end
