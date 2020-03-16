require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do

  describe "GET /create" do
    it "returns http success" do
      post "/feedbacks"
      expect(response).to have_http_status(:success)
    end
  end

end
