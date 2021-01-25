require "rails_helper"

RSpec.describe "routes for ivrs" do
  it "routes to create dictionary" do
    expect(post("/api/v1/ivrs")).to route_to("api/v1/ivrs#create", format: :json)
  end
end
