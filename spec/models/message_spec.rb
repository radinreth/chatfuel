# == Schema Information
#
# Table name: messages
#
#  id                  :bigint(8)        not null, primary key
#  content_type        :string
#  last_interaction_at :datetime         default(Mon, 03 Aug 2020 10:01:25 +07 +07:00)
#  platform_name       :string           default("")
#  repeated            :boolean          default(FALSE)
#  status              :integer(4)       default("incomplete")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content_id          :integer(4)
#  district_id         :string(8)
#  province_id         :string
#
# Indexes
#
#  index_messages_on_content_type_and_content_id  (content_type,content_id)
#
require "rails_helper"

RSpec.describe Message do
  it { is_expected.to have_many(:trackings) }

  describe "associations" do
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

      it "clones when starts new session" do
        old_message = create(:message, content: content, province_id: '12', district_id: '1234')
        old_message.completed!

        new_message = described_class.create_or_return("Messenger", content)

        expect(old_message.province_id).to eq(new_message.province_id)
        expect(old_message.district_id).to eq(new_message.district_id)
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

  describe 'before_update, #set_province_id' do
    let(:message) { create(:message, province_id: '01') }

    before {
      message.update(district_id: '0202')
    }

    it { expect(message.province_id).to eq('02') }
  end

  describe "#last_completed" do
    let(:text_message) { create(:text_message) }
    let!(:message1) { create(:message, :completed, :basic_info, content: text_message) }
    let!(:message2) { create(:message, content: text_message) }
    let!(:message3) { create(:message, content: text_message) }

    it "#last_completed" do
      expect(message3.last_completed).to eq(message1)
    end
  end

  describe "#clone" do
    let!(:gender) { create(:variable, :gender) }
    let!(:location) { create(:variable, :location) }

    it "clones relations" do
      old_message = create(:message, :text, district_id: '0204', gender: 'male')
      old_message.completed!

      new_message = create(:message, :text)
      allow(new_message).to receive(:last_completed_before).and_return old_message

      expect {
        new_message.clone
      }.to change { StepValue.count }
    end
  end
end
