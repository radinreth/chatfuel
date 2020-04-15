# frozen_string_literal: true

# == Schema Information
#
# Table name: site_settings
#
#  id                      :bigint(8)        not null, primary key
#  digest_message_template :text
#  enable_notification     :boolean          default("false")
#  message_frequency       :integer(4)
#  message_template        :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  site_id                 :bigint(8)        not null
#
# Indexes
#
#  index_site_settings_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
class SiteSetting < ApplicationRecord
  belongs_to :site
  has_many :site_settings_telegram_chat_groups
  has_many :telegram_chat_groups, through: :site_settings_telegram_chat_groups

  accepts_nested_attributes_for :site_settings_telegram_chat_groups, allow_destroy: true

  enum message_frequency: {
    immediately: 1,
    daily: 2,
    weekly: 3,
    monthly: 4
  }

  FEEDBACK_AUDIO = "{{feedback_audio}}"
  FEEDBACK_TEXT = "{{feedback_text}}"
  FEEDBACK_AUDIO_COUNT = "{{feedback_text_count}}"
  FEEDBACK_TEXT_COUNT = "{{feedback_text_count}}"
  FEEDBACK_FREEQUENCY = "{{feedback_frequency}}"

  def message_variables
    [FEEDBACK_AUDIO, FEEDBACK_TEXT]
  end

  def digest_message_variables
    [FEEDBACK_AUDIO_COUNT, FEEDBACK_TEXT_COUNT, FEEDBACK_FREEQUENCY]
  end

  def notification_message
    message_template
  end

  def notification_digest_message
    digest_message_template
  end
end
