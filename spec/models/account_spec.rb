require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { should have_one(:customer) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:account)).to be_valid
    end
  end
end