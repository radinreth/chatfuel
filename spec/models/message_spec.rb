# == Schema Information
#
# Table name: messages
#
#  id                  :bigint(8)        not null, primary key
#  content_type        :string
#  last_interaction_at :datetime         default("2020-06-30 04:09:55.715753")
#  platform_name       :string           default("")
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content_id          :integer(4)
#
# Indexes
#
#  index_messages_on_content_type_and_content_id  (content_type,content_id)
#
require "rails_helper"

RSpec.describe Message do
  describe "associations" do
    it { should have_many(:steps) }
    it { should belong_to(:content) }
  end

  describe "delegates" do
    it { should delegate_method(:type).to(:content) }
    it { should delegate_method(:session_id).to(:content) }
  end

  describe ".create_or_return" do
    let(:content) { build(:voice_message) }

    context "existence" do
      it "create a new message if not exist" do
        expect {
          described_class.create_or_return("Messenger", content)
        }.to(change { Message.count })
      end

      it "returns if already created" do
        create(:message, content: content)

        expect do
          described_class.create_or_return("Messenger", content)
        end.not_to(change { Message.count })
      end
    end

    context "completion" do
      before do
        @message = create(:message, content: content)
      end

      it "returns if incompleted" do
        expect do
          described_class.create_or_return("Messenger", content)
        end.not_to(change { Message.count })
      end

      it "creates if completed" do
        create(:message, content: content, status: :completed)

        expect do
          described_class.create_or_return("Messenger", content)
        end.to(change { Message.count })
      end
    end
  end

  describe "#completed?" do
    let(:voice_message) { build(:voice_message) }
    let(:message) { build(:message, content: voice_message, status: :completed) }

    before do
      @message = create(:message, content: voice_message)
    end

    it "is not complete" do
      expect(@message).not_to be_completed
    end

    it "considers completed if their steps contains done=true" do
      expect(message).to be_completed
    end
  end

  describe ".load_by_role" do
    let(:role) { build(:role, :site_admin) }
    let(:variable) { build(:variable, roles: [role]) }
    let(:variable_value) { build(:variable_value, variable: variable) }
    let(:step) { build(:step, value: variable_value) }
    let(:message) { create(:message, :text) }

    it "return empty message" do
      message
      expect(Message.load_by_role(role)).to eq []
    end

    it "includes by assigned role" do
      message.steps << step
      expect(Message.load_by_role(role)).to eq [message]
    end
  end
end
