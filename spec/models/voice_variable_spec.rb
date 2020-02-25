# == Schema Information
#
# Table name: variables
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  name       :string
#  value      :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe VoiceVariable do
  it { is_expected.to be_a_kind_of(Variable) }
end
