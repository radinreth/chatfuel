# == Schema Information
#
# Table name: role_variables
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role_id     :bigint(8)        not null
#  variable_id :bigint(8)        not null
#
# Indexes
#
#  index_role_variables_on_role_id      (role_id)
#  index_role_variables_on_variable_id  (variable_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (variable_id => variables.id)
#
class RoleVariable < ApplicationRecord
  belongs_to :role
  belongs_to :variable
end
