require "rails_helper"

RSpec.describe SocialShare do
  it { is_expected.to have_attribute(:site_name) }
  
  context "WITHOUT :site_name" do
    let(:social_share) { build(:social_share) }

    it "is invalid" do
      expect(social_share).to be_invalid
    end
  end

  context "WITH :site_name" do
    let(:social_share) { build(:social_share, site_name: "facebook") }

    it "is valid" do
      expect(social_share).to be_valid
    end

    it "is invalid" do
      social_share.site_name = "invalid_site"
      expect(social_share).to be_invalid
    end
  end
end
