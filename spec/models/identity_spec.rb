# == Schema Information
#
# Table name: identities
#
#  id         :bigint(8)        not null, primary key
#  provider   :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Identity, type: :model do
  it { is_expected.to have_attribute(:provider) }
  it { is_expected.to have_attribute(:token) }
  it { is_expected.to belong_to(:user) }
end
