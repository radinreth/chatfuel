require "rails_helper"

RSpec.describe Bots::Feedbacks::ChatbotController, type: :request do
  describe "GET /create" do
    let(:text_message) { create(:text_message, messenger_user_id: 123) }

    before do
      create(:message, content: text_message)
    end

    it "returns http success" do
      post "/bots/feedbacks/chatbot", params: { messenger_user_id: 123, klass: "Text", act: "tracking_ticket", value: "1111" }

      expect(response).to have_http_status(:success)
    end
  end
end
