require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:rf) { build(:recipe_food) }

  describe 'validations' do
    it 'should not be valid without a quantity' do
      rf.quantity = nil
      expect(rf).to_not be_valid
    end
    it 'should not be valid with a quantity less than 0' do
      rf.quantity = -1
      expect(rf).to_not be_valid
    end
    it 'should be valid with a positive quantity' do
      rf.quantity = 5
      expect(rf).to be_valid
    end
  end
end
