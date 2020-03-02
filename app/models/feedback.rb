# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint(8)        not null, primary key
#  media_url  :string
#  status     :integer(4)       default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feedback < ApplicationRecord
  enum status: %i[satisfied disatisfied]
  belongs_to :step
end
