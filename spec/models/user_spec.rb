# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  gender                 :string
#  mid                    :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer(4)       default("0")
#  status                 :integer(4)       default("0")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint(8)        default("1"), not null
#  site_id                :bigint(8)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_site_id               (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to define_enum_for(:status).with_values(%i[disable enable]) }
  it { is_expected.to have_many(:identities).dependent(:destroy) }
  it { is_expected.to belong_to(:site).optional }
end
