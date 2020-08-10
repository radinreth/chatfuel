# == Schema Information
#
# Table name: variable_values
#
#  id                :bigint(8)        not null, primary key
#  mapping_value     :string           default("")
#  raw_value         :string           not null
#  status            :string           default("1")
#  step_values_count :integer(4)       default("0")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  variable_id       :bigint(8)        not null
#
# Indexes
#
#  index_variable_values_on_variable_id  (variable_id)
#
# Foreign Keys
#
#  fk_rails_...  (variable_id => variables.id)
#
class VariableValue < ApplicationRecord
  enum status: { satisfied: "0", normal: "1", disatisfied: "2" }

  # associations
  belongs_to :variable
  has_many :step_values

  # validations
  validates :raw_value, presence: true
  default_scope -> { order(:mapping_value) }

  scope :distinct_values, -> { select("distinct on (mapping_value) mapping_value, raw_value") }

  # Callback
  before_destroy :ensure_destroyable
  before_create :set_mapping_value

  def destroyable?
    step_values_count.zero?
  end

  delegate :name, to: :variable, prefix: true
  delegate :feedback_message?, to: :variable, prefix: false
  delegate :is_location?, to: :variable, prefix: false

  private
    def ensure_destroyable
      return if destroyable?

      errors.add(:base, "cannot be deleted!")
      throw :abort
    end

    def set_mapping_value
      self.mapping_value = self.raw_value
    end
end
