require "rails_helper"

RSpec.describe Api::V1::ChatbotsController, type: :controller do
  

  describe "routes" do
    it { should route(:post, "/api/v1/chatbots").to(action: :create, format: :json) }
    it { should route(:post, "/api/v1/chatbots/mark_as_completed").to(action: :mark_as_completed, format: :json) }
    # it { should route(:put, "/api/v1/me").to(action: :check, format: :json) }
    # it { should route(:patch, "/api/v1/sites/0202").to(action: :update, site_code: "0202", format: :json)  }
  end

  describe "actions" do
    let(:site) { create(:site) }

    before do
      request.headers["Authorization"] = "Bearer #{site.token}"
    end

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
      let(:session) { build(:session, session_id: 123) }

      # before do
      #   post :mark_as_completed, params: { messenger_user_id: 123, name: "main_menu", value: "owso_info" }
      # end

      specify { expect(session).to be_incomplete }
    end
  end
end
