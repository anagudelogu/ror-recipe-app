require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  describe '#price' do
    it 'returns the total price to prepare the recipe' do
      recipe.save
      f1 = create(:food, price: 1.5)
      f2 = create(:food, price: 2.5)

      create(:recipe_food, recipe:, food: f1)
      create(:recipe_food, recipe:, food: f2)

      expect(recipe.price).to eq(f1.price + f2.price)
    end
  end

  describe 'validations' do
    context 'when name is missing' do
      it 'should not be valid' do
        recipe.name = nil
        expect(recipe).not_to be_valid
      end
    end

    context 'when preparation time is missing' do
      it 'should not be valid' do
        recipe.preparation_time = nil
        expect(recipe).not_to be_valid
      end
    end

    context 'when cooking time is missing' do
      it 'should not be valid' do
        recipe.cooking_time = nil
        expect(recipe).not_to be_valid
      end
    end

    context 'when description is missing' do
      it 'should not be valid' do
        recipe.description = nil
        expect(recipe).not_to be_valid
      end
    end

    context 'when all parameters are given' do
      it 'should be valid' do
        expect(recipe).to be_valid
      end
    end
  end
end
