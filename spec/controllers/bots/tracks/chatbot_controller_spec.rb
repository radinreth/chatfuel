require "rails_helper"

RSpec.describe Bots::Tracks::ChatbotController, type: :controller do
  let!(:template) { create(:template, status: "incomplete", type: "MessengerTemplate") }

  before do
    content = create(:text_message, messenger_user_id: 123)
    create(:message, content: content)
    create(:ticket, code: "1234-56789")
  end

  it "POST :create" do
    params = { platform_name: "Messenger", messenger_user_id: 123, code: "1234-56789" }

    post :create, params: params

    expect(response).to have_http_status(:ok)
  end
end
