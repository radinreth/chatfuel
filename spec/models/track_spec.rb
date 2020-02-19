require 'rails_helper'

RSpec.describe Track, type: :model do
  it { should have_attribute(:code) }
end
