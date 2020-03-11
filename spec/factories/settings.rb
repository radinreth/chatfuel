# == Schema Information
#
# Table name: settings
#
#  id               :bigint(8)        not null, primary key
#  completed_text   :text
#  uncompleted_text :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :setting do
    uncompleted_text { "MyText" }
    completed_text { "MyText" }
  end
end
