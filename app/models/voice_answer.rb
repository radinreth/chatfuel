class VoiceAnswer < ApplicationRecord
  belongs_to :voice_message

  scope :f1, -> { find_by(project_variable_name: 'f1') || BlankStep.new }
  scope :f11, -> { find_by(project_variable_name: 'f11') || BlankStep.new }
  scope :f111, -> { find_by(project_variable_name: 'f111') || BlankStep.new }
  scope :f112, -> { find_by(project_variable_name: 'f112') || BlankStep.new }
  scope :f113, -> { find_by(project_variable_name: 'f113') || BlankStep.new }
  scope :f12, -> { find_by(project_variable_name: 'f12') || BlankStep.new }
  scope :f121, -> { find_by(project_variable_name: 'f121') || BlankStep.new }
  scope :f122, -> { find_by(project_variable_name: 'f122') || BlankStep.new }
  scope :f13, -> { find_by(project_variable_name: 'f13') || BlankStep.new }
  scope :f131, -> { find_by(project_variable_name: 'f131') || BlankStep.new }

end
