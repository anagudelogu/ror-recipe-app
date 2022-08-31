require 'rails_helper'

RSpec.describe 'food/index', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    user.confirm
    @f1 = create(:food, name: 'apple', measurement_unit: 'kg', price: 1.5, quantity: 1, user:)
    @f2 = create(:food, name: 'banana', measurement_unit: 'unit', price: 0.5, quantity: 12, user:)
    @f3 = create(:food, name: 'orange', measurement_unit: 'kg', price: 1.8, quantity: 1, user:)
    visit foods_path
  end

  describe 'Navigates through the page with no problems' do
    context 'The page shows the correct information' do
      # The page has a button to create a new food
      it 'has a button to create a new food' do
        expect(page).to have_content('Add Food')
      end
      # The page has a table with four columns: food, measurement unit, unit price and actions
      it 'has a table with four columns: food, measurement unit, unit price and actions' do
        expect(page).to have_selector('th', text: 'Food')
        expect(page).to have_selector('th', text: 'Measurement Unit')
        expect(page).to have_selector('th', text: 'Unit Price')
        expect(page).to have_selector('th', text: 'Actions')
      end
      # The column of food display a list with all names of foods that the user has
      it 'the column of food display a list with all names of foods that the user has' do
        within('tbody') do
          rows_elements = all('tr', count: 3)
          rows = rows_elements.map(&:text)
          names = []
          rows.each do |row|
            names << row.split[0]
          end
          expect(names).to contain_exactly(@f1.name, @f2.name, @f3.name)
        end
      end
      # The column of measurment display a list with all measurement units that the food has
      it 'the column of measurment display a list with all measurement units that the food has' do
        within('tbody') do
          rows_elements = all('tr', count: 3)
          rows = rows_elements.map(&:text)
          units = []
          rows.each do |row|
            units << row.split[1]
          end
          expect(units).to contain_exactly(@f1.measurement_unit, @f2.measurement_unit, @f3.measurement_unit)
        end
      end
      # The column of unit price display a list with all unit prices that the food has
      it 'the column of unit price display a list with all unit prices that the food has' do
        within('tbody') do
          rows_elements = all('tr', count: 3)
          rows = rows_elements.map(&:text)
          prices = []
          rows.each do |row|
            prices << row.split[2]
          end
          expect(prices).to contain_exactly(@f1.price.to_s, @f2.price.to_s, @f3.price.to_s)
        end
      end

      # The column of actions display a list of buttons to erase the elements in the row
      it 'the column of actions display a list of buttons to erase the elements in the row' do
        within('tbody') do
          rows_elements = all('tr', count: 3)
          rows = rows_elements.map(&:text)
          actions = []
          rows.each do |row|
            actions << row.split[3]
          end
          expect(actions).to have_content('Delete', count: 3)
        end
      end
    end

    context 'The page has the correct functionality' do
      # When I click on the button to create a new food, I am redirected to the page to create a new food
      context 'when I click on the button to create a new food' do
        it 'should redirected me to the page to create a new food' do
          click_on 'Add Food'
          expect(page).to have_current_path(new_food_path)
        end
      end
      context 'when I click on the button to delete a food' do
        # When I click on the button to delete a food, the food is deleted
        it 'should delete the selected food' do
          within('tbody') do
            expect(all('tr').size).to eq(3)
            within('tr', text: @f2.name) do
              click_on 'Delete'
            end
            expect(page).to have_current_path(foods_path)
            expect(all('tr').size).to eq(2)
          end
        end
      end
    end
  end
end
