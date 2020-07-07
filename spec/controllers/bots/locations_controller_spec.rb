require "rails_helper"

RSpec.describe Bots::LocationsController, type: :controller do
  it "create location" do
    expect {
      post :create, params: { messenger_user_id: 123, platform_name: "Messenger", location_name: "PNP" }
    }.to change { Message.count }.by(1)

    expect(Message.first.location_name).to eq "PNP"
  end
end
