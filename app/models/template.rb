# == Schema Information
#
# Table name: templates
#
#  id            :bigint(8)        not null, primary key
#  content       :string           default("")
#  platform_name :string           default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Template < ApplicationRecord
  enum platform_name: { messenger: "0", telegram: "1", verboice: "2" }

  # associations
  has_one_attached :audio

  # validations
  validates :platform_name, presence: true
  validates :content, presence: true
  validates :platform_name, inclusion: {  in: %w(messenger telegram verboice),
                                          message: "%{value} is not valid platform name" }

  def platform_value
    self.class.platform_names[platform_name]
  end
end
