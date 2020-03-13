# == Schema Information
#
# Table name: site_settings
#
#  id               :bigint(8)        not null, primary key
#  message_template :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
