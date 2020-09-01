require "rails_helper"

RSpec.describe Api::V1::IvrsController, type: :controller do
  describe "routes" do
    it { should route(:post, "/api/v1/ivrs").to(action: :create, format: :json) }
  end

  describe "actions" do
    describe "POST :create" do
      it "creates new record" do
        expect {
          post :create, params: { CallSid: 123, address: '012345678', name: "main_menu", value: "owso_info" }
        }.to change { Variable.count }.by(1)
        .and change { VariableValue.count }.by(1)
        .and change { Session.count }.by(1)
      end
    end
  end
end
