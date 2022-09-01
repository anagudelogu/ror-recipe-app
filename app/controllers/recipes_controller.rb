class RecipesController < ApplicationController
  load_and_authorize_resource
  def index
    @recipes = Recipe.where(user: current_user)
  end

  def show
    @ingredients = @recipe.recipe_foods.includes(:food)
  end

  def new; end

  def create
    recipe = current_user.recipes.build(recipe_params)

    if recipe.save
      redirect_to recipes_path, notice: "Succesfully created recipe #{recipe.name}"
    else
      flash.now[:alert] = recipe.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
