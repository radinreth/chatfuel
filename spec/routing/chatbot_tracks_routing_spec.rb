require "rails_helper"

RSpec.describe "routes to chatbot tracks" do
  it "routes to chatbot_tracks" do
    expect(get("api/v1/chatbot_tracks")).to route_to("api/v1/chatbot_tracks#show", format: :json)
  end
end
