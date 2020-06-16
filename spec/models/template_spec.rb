# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Template, type: :model do
  it { is_expected.to have_attribute(:type) }
  it { is_expected.to have_attribute(:content) }
  # it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to define_enum_for(:status).with_values(incomplete: "0", completed: "1", incorrect: "2").backed_by_column_of_type(:string) }

  describe "methods" do
    let(:template) { build(:template) }

    it "#platform_value" do
      expect(template.platform_value).to eq 0
    end

    it "#status_value" do
      template.completed!

      expect(template.status_value).to eq "1"
    end

    it ".platform_names" do
      platform_names = [["Messenger", "MessengerTemplate"], ["Telegram", "TelegramTemplate"], ["Verboice", "VerboiceTemplate"]]
      expect(described_class.platform_names).to eq platform_names
    end
  end

  describe "validations" do
    describe "#content" do
      context "valid" do
        it "MessengerTemplate with content" do
          template = build(:template, content: "test", type: "MessengerTemplate")

          expect(template).to be_valid
        end
      end

      context "invalid" do
        let(:template) { create(:template) }

        it "without :content" do
          template.content = ""

          expect(template).to be_invalid
        end

        it "without :type" do
          template.type = ""

          expect(template).to be_invalid
          expect(template.errors.messages[:type]).to eq ["can't be blank"]
        end

        it "unexpected :type" do
          template.type = "InvalidTemplate"

          expect(template).to be_invalid
          expect(template.errors.messages[:type]).to eq ["InvalidTemplate is not a valid type"]
        end

        it "VerboiceTemplate has text :content" do
          template.type = "VerboiceTemplate"
          template.content = "should not have"

          expect(template).to be_invalid
        end

        it "MessengerTemplate has :audio" do
          template.audio.attach(io: File.open(file_path("completed_audio.mp3")), filename: "audio.mpg", content_type: "audio/mpeg")

          expect(template).to be_invalid
          expect(template.errors.messages[:base]).to eq ["invalid template provided"]
        end

        it "TelegramTemplate has :audio" do
          template.type = "TelegramTemplate"
          template.audio.attach(io: File.open(file_path("completed_audio.mp3")), filename: "audio.mpg", content_type: "audio/mpeg")

          expect(template).to be_invalid
          expect(template.errors.messages[:base]).to eq ["invalid template provided"]
        end
      end
    end
  end

end
