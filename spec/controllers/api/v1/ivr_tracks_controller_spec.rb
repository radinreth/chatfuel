require "rails_helper"

RSpec.describe Api::V1::IvrTracksController, type: :controller do
  let!(:ticket) { create(:ticket, code: "1234-56789") }

  it "response xml" do
    post :create

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("xml")
  end
end
