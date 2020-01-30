class Message < ApplicationRecord
  belongs_to :content, polymorphic: true
end
