require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'RecipesNew', type: :system do
  context 'when I visit new recipe page' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      user.confirm

      visit new_recipe_path
    end

    it 'shows me a form with name, preparation time, cooking time, description and public fields' do
      within('form', id: 'recipe-form') do
        expect(page).to have_field('Name', type: 'text')
        expect(page).to have_field('Preparation time', type: 'number')
        expect(page).to have_field('Cooking time', type: 'number')
        expect(page).to have_field('Description', type: 'text')
        expect(page).to have_field('Public', type: 'checkbox')
        expect(page).to have_button('Create Recipe')
      end
    end

    context 'when I fill all fields and click create recipe' do
      it 'a new recipe is created and redirects me to recipes list' do
        within('form', id: 'recipe-form') do
          page.fill_in('Name', with: 'Recipe 1')
          page.fill_in('Preparation time', with: '00:30')
          page.fill_in('Cooking time', with: '00:45')
          page.fill_in('Description', with: 'R1 description')
          page.check('Public')

          click_on 'Create Recipe'
        end
        expect(page).to have_current_path(recipes_path)
        within('#recipes-list') do
          expect(all('li').size).to eq(1)
        end
      end
    end

    context 'When a value is not entered' do
      context 'Missing name' do
        it 'shows me the errors' do
          within('form', id: 'recipe-form') do
            page.fill_in('Preparation time', with: '00:30')
            page.fill_in('Cooking time', with: '00:45')
            page.fill_in('Description', with: 'R1 description')
            page.check('Public')

            click_on 'Create Recipe'
          end
          expect(page).to have_selector('div#flash', text: /name/i)
        end
      end

      context 'Missing preparation time' do
        it 'shows me the errors' do
          within('form', id: 'recipe-form') do
            page.fill_in('Name', with: 'Recipe 1')
            page.fill_in('Cooking time', with: '00:45')
            page.fill_in('Description', with: 'R1 description')
            page.check('Public')

            click_on 'Create Recipe'
          end
          expect(page).to have_selector('div#flash', text: /preparation time/i)
        end
      end

      context 'Missing cooking time' do
        it 'shows me the errors' do
          within('form', id: 'recipe-form') do
            page.fill_in('Name', with: 'Recipe 1')
            page.fill_in('Preparation time', with: '00:30')
            page.fill_in('Description', with: 'R1 description')
            page.check('Public')

            click_on 'Create Recipe'
          end
          expect(page).to have_selector('div#flash', text: /cooking time/i)
        end
      end

      context 'Missing description' do
        it 'shows me the errors' do
          within('form', id: 'recipe-form') do
            page.fill_in('Name', with: 'Recipe 1')
            page.fill_in('Preparation time', with: '00:30')
            page.fill_in('Cooking time', with: '00:45')
            page.check('Public')

            click_on 'Create Recipe'
          end
          expect(page).to have_selector('div#flash', text: /description/i)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
