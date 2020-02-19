require 'rails_helper'

RSpec.describe Site, type: :model do
  it { should have_attribute(:name) } 
  it { should have_attribute(:code) }
end
