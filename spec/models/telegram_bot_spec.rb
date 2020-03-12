# frozen_string_literal: true

# == Schema Information
#
# Table name: telegram_bots
#
#  id         :bigint(8)        not null, primary key
#  token      :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe TelegramBot, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:token) }
end
