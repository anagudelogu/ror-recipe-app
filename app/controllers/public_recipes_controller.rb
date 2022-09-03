class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true).includes(:user, :foods).order(id: :desc)
  end
end
