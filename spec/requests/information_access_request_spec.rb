require 'rails_helper'

RSpec.describe "InformationAccesses", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/information_access/index"
      expect(response).to have_http_status(:success)
    end
  end

end
