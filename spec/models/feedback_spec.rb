# == Schema Information
#
# Table name: feedbacks
#
#  id              :bigint(8)        not null, primary key
#  additional_info :string
#  attitude        :string
#  difficulty      :string
#  efficiency      :string
#  overall         :string
#  process         :string
#  provide_info    :string
#  working_time    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  site_id         :bigint(8)
#  step_id         :bigint(8)
#
# Indexes
#
#  index_feedbacks_on_site_id  (site_id)
#  index_feedbacks_on_step_id  (step_id)
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  # attributes
  it { is_expected.to have_attribute(:additional_info) }
  it { is_expected.to have_attribute(:attitude) }
  it { is_expected.to have_attribute(:difficulty) }
  it { is_expected.to have_attribute(:efficiency) }
  it { is_expected.to have_attribute(:overall) }
  it { is_expected.to have_attribute(:process) }
  it { is_expected.to have_attribute(:provide_info) }
  it { is_expected.to have_attribute(:working_time) }

  # associations
  it { is_expected.to belong_to(:step).optional }
  it { is_expected.to belong_to(:site).optional }
end
