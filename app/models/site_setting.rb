# == Schema Information
#
# Table name: site_settings
#
#  id               :bigint(8)        not null, primary key
#  message_template :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  site_id          :bigint(8)        not null
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

  FEEDBACK_AUDIO = "{{feedback_audio}}"
  FEEDBACK_TEXT = "{{feedback_text}}"

  def message_variables
    [FEEDBACK_AUDIO, FEEDBACK_TEXT]
  end
end
