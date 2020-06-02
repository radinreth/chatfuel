require "rails_helper"

RSpec.describe TemplateHelper do
  describe "fontawesome class name #icon_name" do
    it ".facebook-square" do
      expect(icon_name("messenger")).to eq "facebook-square"
    end

    it ".telegrame" do
      expect(icon_name("telegram")).to eq "telegram"
    end

    it ".verboice" do
      expect(icon_name("verboice")).to eq "phone-square"
    end
  end
end
