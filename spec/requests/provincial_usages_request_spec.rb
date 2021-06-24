require 'rails_helper'

RSpec.describe "ProvincialUsages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/provincial_usages/index"
      expect(response).to have_http_status(:success)
    end
  end

end
