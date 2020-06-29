require "rails_helper"

RSpec.describe Bots::GendersController, type: :controller do
  it "create gender" do
    expect {
      post :create, params: { messenger_user_id: 123, platform_name: 'Messenger', gender: 'f' }
    }.to change { Message.count }.by(1)

    expect(TextMessage.first.gender).to eq "f"
  end
end
