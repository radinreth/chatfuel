require "rails_helper"

RSpec.describe "routes to chatbot tracks" do
  it "routes to chatbot_tracks" do
    expect(post("api/v1/chatbot_tracks")).to route_to("api/v1/chatbot_tracks#create", format: :json)
  end
end
