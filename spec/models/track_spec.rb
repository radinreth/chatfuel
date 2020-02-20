require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'attributes' do
    it { should have_attribute(:code) }
  end

  describe 'associations' do
    it { should belong_to(:site).optional }
    it { should belong_to(:step).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:code) }
  end

  describe '#site_code' do
    let(:track) { build(:track, code: '1234-56789') }
    
    it 'substring code to get site_code' do
      expect(track.site_code).to eq "1234"
    end
  end
end
