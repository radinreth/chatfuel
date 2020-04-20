# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Template < ApplicationRecord
  validates :content, presence: true
  validate :only_one_template

  private
    def only_one_template
      errors.add(:base, "multiple templates is not allowed") if Template.count >= 1
      throw :abort
    end
end
