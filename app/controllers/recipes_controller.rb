class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user: current_user)
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
