require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'RecipesList', type: :system do
  context 'as an user' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      user.confirm

      @r1 = create(:recipe, user:, name: 'r1')
      @r2 = create(:recipe, user:, name: 'r2')
      @r3 = create(:recipe, user:, name: 'r3')

      5.times { create(:recipe) }
      visit recipes_path
    end

    context 'when I visit recipes page' do
      it 'shows me a list with only the recipes that I have created' do
        within('#recipes-list') do
          expect(all('li').size).to eq(3)
        end
      end

      it 'shows me all recipes names' do
        within('#recipes-list') do
          name_elements = all('h3', count: 3)
          names = name_elements.map(&:text)
          expect(names).to contain_exactly(@r1.name, @r2.name, @r3.name)
        end
      end

      it 'shows me all recipes descriptions' do
        within('#recipes-list') do
          description_elements = all('p', count: 3)
          descriptions = description_elements.map(&:text)
          expect(descriptions).to contain_exactly(@r1.description, @r2.description, @r3.description)
        end
      end

      it 'shows me a delete button for every recipe' do
        within('#recipes-list') do
          expect(all('button', text: 'DELETE').size).to eq(3)
        end
      end

      it 'shows me a button to Add new recipes' do
        expect(page).to have_link(text: /add recipe/i)
      end

      context 'when I click Add recipes button' do
        it 'takes me to a form to create a new recipe' do
          click_on 'Add recipe'
          expect(page).to have_current_path(new_recipe_path)
        end
      end

      context 'when I click Delete recipes button' do
        it 'should delete the clicked recipe' do
          within('#recipes-list') do
            within('li', text: @r2.name) do
              click_on 'DELETE'
            end
            expect(all('li').size).to eq(2)
          end
        end
      end

      context 'when I click on the recipes title' do
        it 'takes me to the details of that recipe' do
          within('#recipes-list') do
            click_on @r1.name
            expect(page).to have_current_path(recipe_path(@r1))
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
