# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  deleted_at   :datetime
#  lat          :float
#  lng          :float
#  name_en      :string           not null
#  name_km      :string
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
#  index_sites_on_deleted_at  (deleted_at)
#  index_sites_on_name_en     (name_en)
#
class SiteSerializer < ActiveModel::Serializer
  attributes :name, :status, :sync_status
end
