require 'rails_helper'

RSpec.describe "CitizenFeedbacks", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/citizen_feedback/index"
      expect(response).to have_http_status(:success)
    end
  end

end
