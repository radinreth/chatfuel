# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :activities, dependent: :destroy
  has_many :identities, dependent: :destroy

  def last_block
    activities.last.to_block
  end
end
