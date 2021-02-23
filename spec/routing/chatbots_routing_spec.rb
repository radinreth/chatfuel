require "rails_helper"

RSpec.describe "routes for chatbots" do
  it "routes to create dictionary" do
    expect(post("/api/v1/chatbots")).to route_to("api/v1/chatbots#create", format: :json)
  end

  it "routes to preview map" do
    expect(get("/api/v1/map_preview")).to route_to("api/v1/map_previews#show", format: :json, locale: 'km')
  end

  it "routes to mark_as_completed" do
    expect(post("/api/v1/chatbots/mark_as_completed")).to route_to("api/v1/chatbots#mark_as_completed", format: :json)
  end
end
