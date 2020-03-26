require 'rails_helper'

RSpec.describe "Roles", type: :request do

  describe "GET /updates" do
    it "returns http success" do
      get "/roles/updates"
      expect(response).to have_http_status(:success)
    end
  end

end
