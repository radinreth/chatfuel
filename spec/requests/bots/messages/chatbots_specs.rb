require "rails_helper"

RSpec.describe "Chatbot session", type: :request do
  it "cannot access protected route" do
    expect {
      post "/bots/messages/chatbot", params: { platform_name: "Messenger", messenger_user_id: "123", name: "main_menu", value: "owso_info" }
    }.to raise_error(ActionController::RoutingError)
  end

  context "Whitelist ips" do
    before do
      ENV["ALLOWED_HOSTS"] = "127.0.0.1"
    end

    it "creates new session" do
      post "/bots/messages/chatbot", params: { platform_name: "Messenger", messenger_user_id: "123", name: "main_menu", value: "owso_info" }

      expect(response).to have_http_status(:ok)
    end
  end
end
