# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe MessengerTemplate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
