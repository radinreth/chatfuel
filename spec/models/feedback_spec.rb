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
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
