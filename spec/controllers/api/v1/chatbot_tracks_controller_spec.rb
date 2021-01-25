require "rails_helper"

RSpec.describe Api::V1::ChatbotTracksController, type: :controller do
  let!(:template) { create(:template, status: "incomplete", type: "MessengerTemplate") }
  let!(:ticket) { create(:ticket, code: "1234-56789") }

  before do
    content = create(:text_message, messenger_user_id: 123)
    create(:message, content: content)
  end

  it "GET :show" do
    params = { platform_name: "Messenger", messenger_user_id: 123, code: "1234-56789" }

    get :show, params: params

    expect(response).to have_http_status(:ok)
  end

  it "response with ticket status complete" do
    ticket.approve!

    params = { platform_name: "Messenger", messenger_user_id: 123, code: "1234-56789" }

    get :show, params: params

    expect(response.body).to include("completed")
  end
end
