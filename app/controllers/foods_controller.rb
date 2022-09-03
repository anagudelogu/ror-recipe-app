class FoodsController < ApplicationController
  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      flash[:success] = 'Food created successfully'
      redirect_to foods_path
    else
      flash.now[:alert] = recipe.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @foods = current_user.foods
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:success] = 'Food deleted successfully'
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
