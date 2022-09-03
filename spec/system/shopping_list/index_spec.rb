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
    @f3 = create(:food, name: 'orange', quantity: 0, user:, price: 3)
    @r1 = create(:recipe, name: 'apple pie', user:)
    @r2 = create(:recipe, name: 'banana pie', user:)
    @r3 = create(:recipe, name: 'orange pie', user:)
    @rf1 = create(:recipe_food, food: @f1, recipe: @r1, quantity: 5)
    @rf2 = create(:recipe_food, food: @f2, recipe: @r2, quantity: 2)
    @rf3 = create(:recipe_food, food: @f3, recipe: @r3, quantity: 10)
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
      it 'should show the list of food names that is missing for all recipes of the logged-in user' do
        within('tbody') do
          rows_elements = all('tr', count: 2)
          rows = rows_elements.map(&:text)
          names = []
          rows.each do |row|
            names << row.split[0]
          end
          expect(names).to contain_exactly(@f1.name, @f3.name)
        end
      end

      it 'should show the food quantity that is missing for all recipes of the logged-in user' do
        within('tbody') do
          rows_elements = all('tr', count: 2)
          rows = rows_elements.map(&:text)
          quantities = []
          rows.each do |row|
            quantities << row.split[1].to_i
          end
          expect(quantities).to contain_exactly(@rf1.quantity - @f1.quantity, @rf3.quantity - @f3.quantity)
        end
      end

      it 'should show the price for all foods that are missing for all recipes of the logged-in user' do
        within('tbody') do
          rows_elements = all('tr', count: 2)
          rows = rows_elements.map(&:text)
          prices = []
          rows.each do |row|
            prices << row.split[2].to_f
          end
          expect(prices).to contain_exactly((@rf1.quantity - @f1.quantity) * @f1.price,
                                            (@rf3.quantity - @f3.quantity) * @f3.price)
        end
      end
      # Should show the quantity of each food
      it 'should show me the total food items of the shopping list' do
        expect(page).to have_content(/total ingredients: #{within('tbody') { all('tr').size }}/i)
      end
      # Should show the total price of each food
      it 'should show me the total price of the list' do
        expect(page).to have_selector('div', text: /total price: 33/i)
      end
    end
  end
end
