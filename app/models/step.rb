class BlankStep
  def value
    '-'
  end
end

class Step < ApplicationRecord
  belongs_to :message

  scope :f1, -> { find_by(act: 'f1') || BlankStep.new }
  scope :f11, -> { find_by(act: 'f11') || BlankStep.new }
  scope :f111, -> { find_by(act: 'f111') || BlankStep.new }
  scope :f112, -> { find_by(act: 'f112') || BlankStep.new }
  scope :f113, -> { find_by(act: 'f113') || BlankStep.new }
  scope :f12, -> { find_by(act: 'f12') || BlankStep.new }
  scope :f121, -> { find_by(act: 'f121') || BlankStep.new }
  scope :f122, -> { find_by(act: 'f122') || BlankStep.new }
  scope :f13, -> { find_by(act: 'f13') || BlankStep.new }
  scope :f131, -> { find_by(act: 'f131') || BlankStep.new }

  def to_block
    act.to_s.downcase.sub(/set_/, 'ask ')
  end
end
