# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id               :bigint(8)        not null, primary key
#  completed_text   :text
#  uncompleted_text :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "rails_helper"

RSpec.describe Setting, type: :model do
  describe "completed_audio" do
    let!(:setting) { create(:setting, :with_completed_audio) }

    it { is_expected.to validate_content_type_of(:completed_audio).allowing("audio/mpeg") }

    it "should has one completed audio" do
      expect(setting.completed_audio.attached?).to eq(true)
      expect(setting.completed_audio.filename.to_s).to eq("completed_audio.mp3")
    end
  end

  describe "uncompleted_audio" do
    let!(:setting) { create(:setting, :with_uncompleted_audio) }

    it { is_expected.to validate_content_type_of(:uncompleted_audio).allowing("audio/mpeg") }

    it "should has one uncompleted audio" do
      expect(setting.uncompleted_audio.attached?).to eq(true)
      expect(setting.uncompleted_audio.filename.to_s).to eq("uncompleted_audio.mp3")
    end
  end
end
