# == Schema Information
#
# Table name: text_messages
#
#  id                :bigint(8)        not null, primary key
#  first_name        :string
#  gender            :string
#  last_name         :string
#  profile_pic_url   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  messenger_user_id :string           not null
#  province_id       :string
#
class TextMessage < ApplicationRecord
  # associations
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :messenger_user_id

  def type
    "Chatbot"
  end

  def self.user_count(params = {})
    scope = all
    scope = scope.joins(message: { steps: { value: :variable } })
    scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
    scope = scope.where(messages: { platform_name: params[:platform_name] }) if params[:platform_name].present?
    scope = scope.where("DATE(messages.created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope.count
  end
end
