require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should belong_to(:account) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:customer)).to be_valid
    end
  end

  describe 'callbacks' do
    it 'automatically generates a valid Chilean RUT' do
      customer = create(:customer)
      expect(customer.rut).to match(/\A\d{1,2}\.\d{3}\.\d{3}[-][0-9kK]\z/)
    end
  end
end