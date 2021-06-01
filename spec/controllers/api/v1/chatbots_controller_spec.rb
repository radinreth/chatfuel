require "rails_helper"

RSpec.describe Api::V1::ChatbotsController, type: :controller do
  describe "routes" do
    it { should route(:post, "/api/v1/chatbots").to(action: :create, format: :json) }
    it { should route(:post, "/api/v1/chatbots/mark_as_completed").to(action: :mark_as_completed, format: :json) }
  end

  describe "actions" do
    before do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    end

    describe "POST :create" do
      it "creates new record" do
        expect {
          post :create, params: { messenger_user_id: 123, name: "main_menu", value: "owso_info" }
        }.to have_performed_job(Session::ChatbotJob)
      end
    end

    describe "PUT :mark_as_completed" do
      let!(:session) { create(:session, platform_name: "Messenger") }

      before do
        session.incomplete!
      end

      specify { expect(session).to be_incomplete }

      it "completed" do
        expect {
          post :mark_as_completed, params: { messenger_user_id: session.session_id, name: "main_menu", value: "owso_info" }
        }.to have_performed_job(Session::Chatbot::MarkStatusJob)
      end
    end
  end
end
