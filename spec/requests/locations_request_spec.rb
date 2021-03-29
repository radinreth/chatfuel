require "rails_helper"

RSpec.describe "Locations", type: :request do
  before do
    get "/location"
  end

  it "return http status" do
    expect(response).to be_successful
  end
  
  it "returns :display_name, :described_name" do
    expect(response.body).to include("display_name", "described_name")
  end
end
