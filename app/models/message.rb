class Message < ApplicationRecord
  has_many :steps
  belongs_to :content, polymorphic: true
end
