require 'rails_helper'

RSpec.describe PurchaseRequest, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:purchase_request)).to be_valid
    end
  end
end