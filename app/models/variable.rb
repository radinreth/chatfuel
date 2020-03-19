# == Schema Information
#
# Table name: variables
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  text       :string
#  type       :string           not null
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_variables_on_type_and_name_and_value  (type,name,value) UNIQUE
#
class Variable < ApplicationRecord
  validates :type, presence: true
  validates :name, presence: true
  validates :name, format: { with: /\w/, message: "only allows numbers or letters" }, allow_blank: true
end
