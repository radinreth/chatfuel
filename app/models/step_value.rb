# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  site_id           :bigint(8)
#  step_id           :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_site_id            (site_id)
#  index_step_values_on_step_id            (step_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (step_id => steps.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
class StepValue < ApplicationRecord
  belongs_to :step
  belongs_to :variable_value
  belongs_to :site, optional: true
end
