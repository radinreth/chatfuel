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
require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
