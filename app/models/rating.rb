# == Schema Information
#
# Table name: ratings
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  feedback_id :bigint(8)        not null
#  variable_id :bigint(8)        not null
#
# Indexes
#
#  index_ratings_on_feedback_id  (feedback_id)
#  index_ratings_on_variable_id  (variable_id)
#
# Foreign Keys
#
#  fk_rails_...  (feedback_id => feedbacks.id)
#  fk_rails_...  (variable_id => variables.id)
#
class Rating < ApplicationRecord
  belongs_to :feedback
  belongs_to :variable
end
