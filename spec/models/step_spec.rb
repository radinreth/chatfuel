# == Schema Information
#
# Table name: steps
#
#  id :bigint(8)        not null, primary key
#
require "rails_helper"

RSpec.describe Step do
  describe "validations" do
    let(:text_message) { create(:text_message) }
    let(:message) { create(:message, content: text_message) }

    before { create(:step, :accessed) }

    it ".accessed" do
      expect(described_class.accessed.count).to eq 1
      expect(described_class.accessed).to all(be_a(described_class)) 
    end
  end

  describe "associations" do
    it { should belong_to(:message) }
  end
end
