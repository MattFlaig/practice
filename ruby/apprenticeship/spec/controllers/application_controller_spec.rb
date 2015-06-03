require 'rails_helper'

describe ApplicationController do
  describe '#current_order' do
    let(:order) { FactoryGirl.create(:order) }

    context 'with an order already in the session' do
      before(:each) do
        session[:order_id] = order.id
      end

      it 'finds the existing order' do
        expect(controller.view_context.current_order).to eql(order)
      end
    end

    context 'without an order in the session' do
      it 'builds a new order' do
        expect(controller.view_context.current_order).to be_new_record
      end
    end
  end

  describe '#food_categories' do
    let(:food_1) { FactoryGirl.create(:food, category: 0) }
    let(:same_category) { { 0 => [food_1, food_2] } }
    let(:different_categories) { { 0 => [food_1], 1 => [food_3] } }

    it 'puts all foods of the same category into the same array' do
      food_2 = FactoryGirl.create(:food, category: 0)
      same_category = { 0 => [food_1, food_2] }
      expect(controller.view_context.food_categories([food_1, food_2]))
        .to eql(same_category)
    end

    it 'puts foods from different categories into different arrays' do
      food_3 = FactoryGirl.create(:food, category: 1)
      different_categories = { 0 => [food_1], 1 => [food_3] }
      expect(controller.view_context.food_categories([food_1, food_3]))
        .to eql(different_categories)
    end
  end
end
