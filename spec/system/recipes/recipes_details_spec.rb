require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'RecipesDetails', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    user.confirm

    @r1 = create(:recipe, user:, name: 'r1', public: true)

    visit recipe_path(@r1)
  end

  context 'when I visit recipe details page' do
    it 'shows me the recipe name, preparation time, cooking time and description' do
      expect(page).to have_content(@r1.name)
      expect(page).to have_content(/preparation time: #{@r1.preparation_time}/i)
      expect(page).to have_content(/cooking time: #{@r1.cooking_time}/i)
      expect(page).to have_content(/#{@r1.description}/i)
    end

    it 'shows me a button to generate a shopping list' do
      expect(page).to have_link('Generate shopping list')
    end

    it "shows me 'Public' tag" do
      within('#recipe-details') do
        expect(page).to have_content(/public/i)
      end
    end

    context 'when I click on generate shopping list' do
      it 'takes me to the generated shopping list' do
        within('#recipe-details') do
          click_on 'Generate shopping list'
        end
        expect(page).to have_current_path(shopping_list_path)
      end
    end

    context 'if I am the owner' do
      it 'shows me a button to add a new ingredient to the recipe' do
        expect(page).to have_link('Add ingredient')
      end

      context 'When I click on add ingredient' do
        it 'takes me to a form to create a new ingredient' do
          pending
          click_on 'Add ingredient'
          expect(page).to have_current_path(new_food_path)
        end
      end
    end

    context "if I'm not the owner" do
      before do
        @r2 = create(:recipe)
        visit recipe_path(@r2)
      end

      it "doesn't show me a button to add ingredients" do
        expect(page).not_to have_link('Add ingredient')
      end

      context 'and the recipe is not public' do
        it 'redirects me to root path' do
          expect(page).to have_current_path(root_path)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
