# == Schema Information
#
# Table name: site_settings
#
#  id                      :bigint(8)        not null, primary key
#  digest_message_template :text
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
end
