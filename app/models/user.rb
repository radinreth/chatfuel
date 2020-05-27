# frozen_string_literal: true

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
class User < ApplicationRecord
  enum status: %i[disable enable]

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :identities, dependent: :destroy
  belongs_to :site, optional: true
  belongs_to :role

  delegate :system_admin?, :site_admin?, :site_ombudsman?, to: :role
end
