# == Schema Information
#
# Table name: trackings
#
#  id                :bigint(8)        not null, primary key
#  site_code         :string
#  status            :integer(4)
#  ticket_code       :string
#  tracking_datetime :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  message_id        :bigint(8)        not null
#
# Indexes
#
#  index_trackings_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
class Tracking < ApplicationRecord
  enum status: %i[incorrect incomplete completed]

  belongs_to :message

  validates :status, uniqueness: { scope: :message }

  def self.filter(params = {})
    scope = all
    scope = scope.where(message_id: Message.where(gender: params[:gender])) if params[:gender].present?
    scope = scope.where(message_id: Message.where(content_type: params[:content_type])) if params[:content_type].present?
    scope = scope.where(message_id: Message.where(province_id: params[:province_id])) if params[:province_id].present?
    scope = scope.where(message_id: Message.where(district_id: params[:district_id])) if params[:district_id].present?
    scope = scope.where(message_id: Message.where(platform_name: params[:platform_name])) if params[:platform_name].present?
    scope = scope.where("DATE(tracking_datetime) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope
  end
end
