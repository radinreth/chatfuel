require "rails_helper"

RSpec.describe "routes for chatbots" do
  it "routes to create dictionary" do
    expect(post("/api/v1/chatbots")).to route_to("api/v1/chatbots#create", format: :json)
  end

  it "routes to mark_as_completed" do
    expect(post("/api/v1/chatbots/mark_as_completed")).to route_to("api/v1/chatbots#mark_as_completed", format: :json)
  end
end
