# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id               :bigint(8)        not null, primary key
#  completed_text   :text
#  incompleted_text :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Setting < ApplicationRecord
  validate :only_one_record, on: :create

  has_one_attached :incompleted_audio
  has_one_attached :completed_audio

  validates :incompleted_audio, content_type: [:mp3]
  validates :completed_audio, content_type: [:mp3]

  private
    def only_one_record
      if Setting.count > 0
        errors.add(:base, "allow only one setting")
        throw :abort
      end
    end
end
