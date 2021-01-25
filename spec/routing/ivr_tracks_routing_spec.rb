require "rails_helper"

RSpec.describe "routes to ivr tracks" do
  it "routes to ivr_tracks" do
    expect(get("api/v1/ivr_tracks")).to route_to("api/v1/ivr_tracks#show", format: :json)
  end
end
