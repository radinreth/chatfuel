# == Schema Information
#
# Table name: social_shares
#
#  id         :bigint(8)        not null, primary key
#  site_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SocialShare < ApplicationRecord
  SOCIAL_SITES = %w(facebook twitter linkedin)
  validates :site_name, presence: true, inclusion: { in: SOCIAL_SITES }
end
