require "rails_helper"

RSpec.describe Bots::Messages::IvrController, type: :controller do
  it "create verboice variable" do
    expect {
      post :create, params: { callsid: 123, platform_name: "Verboice", name: "main_menu", value: "owso_info" }
    }.to change { Variable.count }.by 1
  end

  it "cannot create variable with unknow platform" do
    unknown_platform = 'test'

    expect {
      post :create, params: { callsid: 123, platform_name: unknown_platform, name: "main_menu", value: "owso_info" }
    }.to raise_error ActiveRecord::RecordInvalid, "Validation failed: Platform name #{unknown_platform} is not a valid platform name"
  end
end
