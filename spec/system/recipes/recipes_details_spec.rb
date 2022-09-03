require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'RecipesDetails', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    user.confirm

    @r1 = create(:recipe, user:, name: 'r1', public: true)

    @f1 = create(:food, name: 'apple')
    @f2 = create(:food, name: 'orange')
    @rf1 = create(:recipe_food, recipe: @r1, food: @f1, quantity: 5)
    @rf2 = create(:recipe_food, recipe: @r1, food: @f2, quantity: 7)

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

    it 'shows me a table with the corresponding headers' do
      expect(page).to have_selector('table')
      table = find('table')
      expect(table).to have_selector('thead')
      within('thead') do
        headers_elements = all('th', count: 4)
        headers = headers_elements.map(&:text)
        expect(headers).to contain_exactly('Food', 'Quantity', 'Value', 'Actions')
      end
    end

    it 'shows me the correct quantity for each ingredient' do
      within('tbody') do
        rows_elements = all('tr', count: 2)
        rows = rows_elements.map(&:text)
        quantities = rows.map { |row| row.split[1].to_i }

        expect(quantities).to contain_exactly(@rf1.quantity, @rf2.quantity)
      end
    end

    it 'shows me the correct total value for each ingredient' do
      within('tbody') do
        rows_elements = all('tr', count: 2)
        rows = rows_elements.map(&:text)
        values = rows.map { |row| row.split[2].to_f }

        expect(values).to contain_exactly(@rf1.quantity * @f1.price, @rf2.quantity * @f2.price)
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

      it 'shows me a button to remove the ingredient' do
        within('tbody') do
          remove_btn_elements = all('button', text: /remove/i, count: 2)
          remove_btns = remove_btn_elements.map(&:text)
          expect(remove_btns).to contain_exactly('Remove', 'Remove')
        end
      end

      context 'When I click on add ingredient' do
        it 'takes me to a form to create a new ingredient' do
          click_on 'Add ingredient'
          expect(page).to have_current_path(new_recipe_recipe_food_path(@r1))
        end
      end

      context 'when I click on remove ingredient' do
        it 'removes the ingredient' do
          within('tbody') do
            expect(all('tr').size).to eq(2)

            within('tr', text: /#{@rf1.food.name}/i) do
              click_on 'Remove'
            end
            expect(all('tr').size).to eq(1)
          end
        end
      end
    end

    context "if I'm not the owner" do
      before do
        @r2 = create(:recipe, public: true)

        @f3 = create(:food, name: 'apple')
        @rf3 = create(:recipe_food, recipe: @r2, food: @f3, quantity: 5)

        visit recipe_path(@r2)
      end

      it "doesn't show me a button to add ingredients" do
        expect(page).not_to have_link('Add ingredient')
      end

      it "doesn't show me a button to remove ingredients" do
        expect(page).not_to have_button('Remove')
      end

      context 'and the recipe is not public' do
        it 'redirects me to root path' do
          @r2.public = false
          @r2.save
          visit recipe_path(@r2)
          expect(page).to have_current_path(root_path)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
