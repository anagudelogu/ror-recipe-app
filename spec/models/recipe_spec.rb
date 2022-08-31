require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    let(:recipe) { build(:recipe) }
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
