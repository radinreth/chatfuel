require "rails_helper"

RSpec.describe Api::V1::IvrTracksController, type: :controller do
  let!(:ticket) { create(:ticket, code: "1234-56789") }
  
  it "" do
    get :show

    expect(response).to have_http_status(:ok)
  end
end
