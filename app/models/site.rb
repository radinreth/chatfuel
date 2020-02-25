# == Schema Information
#
# Table name: sites
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  code         :string           default("")
#  tracks_count :integer          default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Site < ApplicationRecord
  has_many :tracks, dependent: :destroy
end
