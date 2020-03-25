# == Schema Information
#
# Table name: variables
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  report_enabled :boolean          default("false")
#  status         :integer(4)       default("0")
#  text           :string
#  type           :string           not null
#  value          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_variables_on_type_and_name_and_value  (type,name,value) UNIQUE
#
RSpec.describe VoiceVariable do
  it { is_expected.to be_a_kind_of(Variable) }
end
