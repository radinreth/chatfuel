# frozen_string_literal: true

class User < ApplicationRecord
  has_many :activities

  def last_block
    activities.last.to_block
  end
end
