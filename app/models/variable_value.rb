# == Schema Information
#
# Table name: variable_values
#
#  id                :bigint(8)        not null, primary key
#  hint              :string(255)      default("")
#  mapping_value     :string           default("")
#  raw_value         :string           not null
#  status            :string           default("acceptable")
#  step_values_count :integer(4)       default(0)
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
  enum status: { like: "0", acceptable: "1", dislike: "2" }

  # associations
  belongs_to :variable
  has_many :step_values, dependent: :destroy

  # validations
  validates :raw_value, presence: true
  default_scope -> { order(:mapping_value) }

  scope :distinct_values, -> (field = 'mapping_value') { select("DISTINCT ON (#{field}) #{field}, raw_value") }

  # Callback
  before_destroy :ensure_destroyable!
  before_create :set_mapping_value

  def destroyable?
    step_values_count.zero? || raw_value.null_value?
  end

  def ticket_status
    return unless variable.is_ticket_tracking?

    ticket = Ticket.find_by(code: raw_value)

    ticket&.progress_status || "incorrect"
  end

  delegate :name, to: :variable, prefix: true
  delegate :feedback_message?, to: :variable, prefix: false
  delegate :is_location?, to: :variable, prefix: false

  private
    def ensure_destroyable!
      return if destroyable?

      errors.add(:base, I18n.t("deleted.fail"))
      throw :abort
    end

    def set_mapping_value
      self.mapping_value = self.raw_value if self.mapping_value.blank?
    end
end
