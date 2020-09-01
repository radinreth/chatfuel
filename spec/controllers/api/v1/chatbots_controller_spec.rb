require "rails_helper"

RSpec.describe Api::V1::ChatbotsController, type: :controller do
  describe "routes" do
    it { should route(:post, "/api/v1/chatbots").to(action: :create, format: :json) }
    it { should route(:post, "/api/v1/chatbots/mark_as_completed").to(action: :mark_as_completed, format: :json) }
  end

  describe "actions" do
    describe "POST :create" do
      it "creates new record" do
        expect {
          post :create, params: { messenger_user_id: 123, name: "main_menu", value: "owso_info" }
        }.to change { Variable.count }.by(1)
        .and change { VariableValue.count }.by(1)
        .and change { Session.count }.by(1)
      end
    end

    describe "PUT :mark_as_completed" do
      let!(:session) { create(:session) }

      specify { expect(session).to be_incomplete }

      it "completed" do
        post :mark_as_completed, params: { messenger_user_id: session.session_id, name: "main_menu", value: "owso_info" }

        expect(session.reload).to be_completed
      end
    end
  end
end
