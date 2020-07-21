# == Schema Information
#
# Table name: variables
#
#  id               :bigint(8)        not null, primary key
#  feedback_message :boolean          default("false")
#  is_location      :boolean
#  is_most_request  :boolean          default("false")
#  is_user_visit    :boolean          default("false")
#  name             :string
#  report_enabled   :boolean          default("false")
#  type             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
RSpec.describe VoiceVariable do
  it { is_expected.to be_a_kind_of(Variable) }
end
