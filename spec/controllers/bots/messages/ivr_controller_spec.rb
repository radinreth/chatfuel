require "rails_helper"

RSpec.describe Bots::Messages::IvrController, type: :controller do
  it "create verboice variable" do
    expect {
      post :create, params: { callsid: 123, platform_name: "Verboice", name: "main_menu", value: "owso_info" }
    }.to change { Variable.count }.by 1
  end
end
