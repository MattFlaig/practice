require 'rails_helper'
describe Order do
  let(:order) { FactoryGirl.build(:order) }

  describe 'validations' do
    it 'should require total' do
      order.total = nil
      expect(order).not_to be_valid
    end
    it 'should require status' do
      order.status = nil
      expect(order).not_to be_valid
    end
  end
end
