# == Schema Information
#
# Table name: sessions
#
#  id                  :bigint(8)        not null, primary key
#  last_interaction_at :datetime
#  platform_name       :string           default("")
#  session_type        :string           default("")
#  status              :integer(4)       default("incomplete")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  district_id         :string
#  province_id         :string
#  session_id          :string           not null
#
require 'rails_helper'

RSpec.describe Session, type: :model do
  it { is_expected.to define_enum_for(:status).with_values(%i[incomplete completed]) }
  it { is_expected.to have_many(:trackings) }
end
