require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    let(:food) { create(:food, name: 'apple', measurement_unit: 'kg', price: 1.5, quantity: 1, user:) }

    context 'when foods has all parameters' do
      it 'has a name' do
        expect(food.name).to eq('apple')
      end

      it 'has a measurement unit' do
        expect(food.measurement_unit).to eq('kg')
      end

      it 'has a price' do
        expect(food.price).to eq(1.5)
      end

      it 'has a quantity' do
        expect(food.quantity).to eq(1)
      end

      it 'has a user' do
        expect(food.user).to be(user)
      end
    end

    context 'when foods have null parameters is invalid' do
      it 'has a null name' do
        food.name = nil
        expect(food).to_not be_valid
      end

      it 'has a null measurement unit' do
        food.measurement_unit = nil
        expect(food).to_not be_valid
      end

      it 'has a null price' do
        food.price = nil
        expect(food).to_not be_valid
      end

      it 'has a null quantity' do
        food.quantity = nil
        expect(food).to_not be_valid
      end

      it 'has a null user' do
        food.user = nil
        expect(food).to_not be_valid
      end
    end
  end
end
