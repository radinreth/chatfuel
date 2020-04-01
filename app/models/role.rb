# == Schema Information
#
# Table name: roles
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord
  # associations
  has_many :users
  has_many :role_variables
  has_many :variables, through: :role_variables

  def grade
    { "site ombudsman": 0, "site admin": 1, "system admin": 2 }[name.to_sym]
  end

  def system_admin?
    name == "system admin"
  end

  def site_admin?
    name == "site admin"
  end

  def site_ombudsman?
    name == "site ombudsman"
  end
end
