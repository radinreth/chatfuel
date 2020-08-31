require "rails_helper"

RSpec.describe Bots::Messages::ChatbotController, type: :controller do
  it "creates messenger variable" do
    expect {
      post :create, params: { messenger_user_id: 123, platform_name: "Messenger", name: "main_menu", value: "owso_info" }
    }.to change { Variable.count }.by 1

    variable = Variable.first

    expect(variable.name).to eq "main_menu"
    expect(variable.values.count).to eq 1
    expect(variable.values.first.raw_value).to eq "owso_info"
  end

  it "create telegram variable" do
    expect {
      post :create, params: { messenger_user_id: 123, platform_name: "Telegram", name: "main_menu", value: "owso_info" }
    }.to change { Variable.count }.by 1
  end

  it "create verboice variable" do
    expect {
      post :create, params: { messenger_user_id: 123, platform_name: "Verboice", name: "main_menu", value: "owso_info" }
    }.to change { Variable.count }.by 1
  end
end
