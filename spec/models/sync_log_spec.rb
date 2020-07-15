# == Schema Information
#
# Table name: sync_logs
#
#  id         :bigint(8)        not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer(4)
#
require 'rails_helper'

RSpec.describe SyncLog, type: :model do
  it { is_expected.to belong_to(:site) }
end
