class Step < ApplicationRecord
  belongs_to :message

  def to_block
    act.to_s.downcase.sub /set_/, 'ask '
  end
end
