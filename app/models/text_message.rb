class TextMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
end
