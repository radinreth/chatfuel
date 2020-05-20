# == Schema Information
#
# Table name: quota
#
#  id                 :bigint(8)        not null, primary key
#  on_reach_threshold :string           default("delay")
#  platform_name      :string           default("messenger")
#  secure_zone        :float            default("0.75")
#  threshold          :integer(4)       default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe Quotum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
