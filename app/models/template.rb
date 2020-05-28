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
  before_create :only_one_template

  private
    def only_one_template
      return unless Template.exists?

      errors.add(:base, "multiple templates is not allowed")
      throw :abort
    end
end
