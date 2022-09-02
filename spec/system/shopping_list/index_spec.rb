require 'rails_helper'

RSpec.describe 'Shopping-List', type: :system do
  let(:user) { create(:user) }
  let(:food) { create(:food, user:) }
  let(:recipe) { create(:recipe, user:) }

  before do
    sign_in(user)
    user.confirm
    @f1 = create(:food, name: 'apple', quantity: 3, user:, price: 1.5)
    @f2 = create(:food, name: 'banana', quantity: 2, user:, price: 2.5)
    @r1 = create(:recipe, name: 'apple pie', user:)
    @r2 = create(:recipe, name: 'banana pie', user:)
    @rf1 = create(:recipe_food, food: @f1, recipe: @r1, quantity: 5)
    @rf2 = create(:recipe_food, food: @f2, recipe: @r2, quantity: 2)
    visit shopping_list_path
  end

  describe 'shouldbe render the correct page elements' do
    context 'When the page load, should have a table with the correct data inside' do
      # Shouldbe render a table with the correct headers
      it 'shouldbe render a table with the correct headers' do
        within('table') do
          within('thead') do
            expect(page).to have_selector('th', text: 'Food')
            expect(page).to have_selector('th', text: 'Quantity')
            expect(page).to have_selector('th', text: 'Price')
          end
        end
      end
      # Should show the list of food that is missing for all recipes
      #  of the logged-in user (compare the list of food for all recipes
      #  with the general food list of that user).
      it 'should show the list of food that is missing for all recipes of the logged-in user' do
        # require ingredients for all recipes = {apple: 5, banana: 2}
        # user inventory = {apple: 3, banana: 2}
        # missing ingredients = {apple: 2, banana: 0}
        #

        within('tbody') do
          expect(page).to have_selector('tr', count: 1, text: /apple 2 3/i)
        end
      end
      # Should show the quantity of each food
      # Should show the total price of each food
      # Should show the total food items of the missing food.
      # Should show the total price of the missing food.
    end
    # Should count the total food items and total price of the missing food.
  end
end
