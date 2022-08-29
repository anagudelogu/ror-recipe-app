require 'rails_helper'

RSpec.describe 'Navigations', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    user.confirm
  end

  it 'Navigates through the page with no problems' do
    # Root: public recipes
    visit root_path
    # click recipes
    click_on 'Recipes'
    # expect page: recipes
    expect(page).to have_current_path(recipes_path)
    # click foods
    click_on 'Foods'
    # expect page: foods
    expect(page).to have_current_path(foods_path)
    # click shopping_list
    click_on 'Shopping list'
    # expect page: shopping list
    expect(page).to have_current_path(shopping_list_path)
    # click public recipes
    click_on 'Public recipes'
    # expect page: public recipes
    expect(page).to have_current_path(public_recipes_path)
  end
end
