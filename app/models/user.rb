# frozen_string_literal: true

class User < ApplicationRecord
  has_many :activities, dependent: :destroy

  def last_block
    activities.last.to_block
  end
end
