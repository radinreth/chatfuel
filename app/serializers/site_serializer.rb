# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  lat          :float
#  lng          :float
#  name         :string           not null
#  status       :integer(4)       default("0")
#  sync_status  :integer(4)
#  token        :string           default("")
#  tracks_count :integer(4)       default("0")
#  whitelist    :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  province_id  :string
#
# Indexes
#
#  index_sites_on_name  (name)
#
class SiteSerializer < ActiveModel::Serializer
  attributes :name, :status, :sync_status
end
