require "rails_helper"

RSpec.describe Api::V1::SocialSharesController do
  it "cannot create invalid site" do
    post :create, params: { "social_share": { site_name: "invalid" } }

    expect(response).not_to be_successful
  end
  
  it "creates a valid site" do
    post :create, params: { "social_share": { site_name: "facebook" } }

    expect(response).to be_successful
  end
end
