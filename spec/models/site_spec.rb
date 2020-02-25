# == Schema Information
#
# Table name: sites
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  code         :string           default("")
#  tracks_count :integer          default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Site, type: :model do
  it { should have_attribute(:name) } 
  it { should have_attribute(:code) }
end
