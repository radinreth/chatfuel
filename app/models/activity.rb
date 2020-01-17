# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :lead

  def to_block
    name.to_s.downcase.sub /set_/, 'ask '
  end
end
