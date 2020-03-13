# == Schema Information
#
# Table name: site_settings
#
#  id               :bigint(8)        not null, primary key
#  message_template :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class SiteSetting < ApplicationRecord
end
