class BlankStep
  def value
    '-'
  end
end

class Step < ApplicationRecord
  belongs_to :message

  scope :f1, -> { find_by(act: 'f1') || BlankStep.new }
  scope :f11, -> { find_by(act: 'f1.1') || BlankStep.new }
  scope :f111, -> { find_by(act: 'f1.1.1') || BlankStep.new }
  scope :f112, -> { find_by(act: 'f1.1.2') || BlankStep.new }
  scope :f113, -> { find_by(act: 'f1.1.3') || BlankStep.new }
  scope :f12, -> { find_by(act: 'f1.2') || BlankStep.new }
  scope :f121, -> { find_by(act: 'f1.2.1') || BlankStep.new }
  scope :f122, -> { find_by(act: 'f1.2.2') || BlankStep.new }
  scope :f13, -> { find_by(act: 'f1.3') || BlankStep.new }
  scope :f131, -> { find_by(act: 'f1.3.1') || BlankStep.new }

  def to_block
    act.to_s.downcase.sub(/set_/, 'ask ')
  end
end
