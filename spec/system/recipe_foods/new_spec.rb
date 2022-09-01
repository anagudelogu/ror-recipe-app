require 'rails_helper'

RSpec.describe 'Form to add new ingredients:', type: :system do
  context 'as an user' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      user.confirm

      @r1 = create(:recipe, user:)

      @f1 = create(:food, name: 'f1', measurement_unit: 'g', user:)
      @f2 = create(:food, name: 'f2', measurement_unit: 'g', user:)
      @f3 = create(:food, name: 'f3', measurement_unit: 'g', user:)
      @f4 = create(:food, name: 'f4', measurement_unit: 'g', user:)
      @f5 = create(:food, name: 'f5', measurement_unit: 'g', user:)

      visit new_recipe_recipe_food_path(@r1)
    end

    context 'when the form opens ' do
      it 'should have a dropdown with all recipes ingredients' do
        expect(page).to have_select('recipe_food[food_id]', options: ['f1 (g)', 'f2 (g)', 'f3 (g)', 'f4 (g)', 'f5 (g)'])
      end
      it 'should have a text field for the quantity' do
        expect(page).to have_field('recipe_food[quantity]')
      end
      it 'should have a submit button' do
        expect(page).to have_button('Add new Ingredient')
      end
      it 'should have a link to create a new ingredient' do
        expect(page).to have_link('Create a new one', href: new_food_path)
      end
      context 'when the user clicks on the link to create a new ingredient' do
        it 'should open the new ingredient form' do
          click_link('Create a new one')
          expect(page).to have_current_path(new_food_path)
        end
      end
      context 'when the user selects an ingredient and adds a quantity' do
        it 'should add the ingredient to the recipe' do
          select('f1 (g)', from: 'recipe_food[food_id]')
          fill_in('recipe_food[quantity]', with: '100')
          click_button('Add new Ingredient')
          expect(page).to have_current_path(recipe_path(@r1))
          within('tbody') do
            expect(page).to have_content(/f1 100/i)
          end
        end
      end
    end
  end
end
