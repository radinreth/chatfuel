# == Schema Information
#
# Table name: templates
#
#  id            :bigint(8)        not null, primary key
#  content       :string           default("")
#  platform_name :string           default("0")
#  status        :string           default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Template < ApplicationRecord
  enum platform_name: { messenger: "0", telegram: "1", verboice: "2" }
  enum status: { incomplete: "0", completed: "1", incorrect: "2" }

  # associations
  has_one_attached :audio

  # validations
  validates :content, presence: true
  validates :status, uniqueness: { scope: :platform_name }
  validates :platform_name, presence: true
  validates :platform_name, inclusion: {  in: %w(messenger telegram verboice),
                                          message: "%{value} is not valid platform name" }

  def platform_value
    self.class.platform_names[platform_name]
  end

  def status_value
    self.class.statuses[status]
  end
end
