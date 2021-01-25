require "rails_helper"

RSpec.describe "routes to ivr tracks" do
  it "routes to ivr_tracks" do
    expect(post("api/v1/ivr_tracks")).to route_to("api/v1/ivr_tracks#create", format: :json)
  end
end
