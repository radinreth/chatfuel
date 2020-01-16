# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :user

  def to_block
    name.downcase.sub /set_/, 'ask '
  end
end
