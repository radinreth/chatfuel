# == Schema Information
#
# Table name: variables
#
#  id               :bigint(8)        not null, primary key
#  feedback_message :boolean          default("false")
#  name             :string
#  report_enabled   :boolean          default("false")
#  type             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  site_id          :integer(4)
#
class TextVariable < Variable
end
