require 'rails_helper'

RSpec.describe 'food/new', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    user.confirm
    visit new_food_path
  end
  describe 'This view have to render the correct fields' do
    it 'renders the new food form' do
      expect(page).to have_selector('form', id: 'new-food-form')
    end
    it 'should display a form with a name field' do
      expect(page).to have_field('Name')
    end
    it 'should display a form with a price field' do
      expect(page).to have_field('Price')
    end

    it 'should display a form with a submit button' do
      expect(page).to have_button('Add new Food')
    end
    it 'should add a new element to database once the form is submitted' do
      within('form', id: 'new-food-form') do
        page.fill_in 'Name', with: 'grapes'
        page.fill_in 'Price', with: '10'

        click_on 'Add new Food'
      end
      expect(page).to have_current_path(foods_path)
      within('tbody') do
        expect(all('tr').count).to eq(1)
      end
    end
  end
end
