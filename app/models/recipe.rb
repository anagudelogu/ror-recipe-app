class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true

  def price
    price = 0
    foods.each do |food|
      price += food.price
    end
    price.round(2)
  end

  def ingredients
    hash = {}
    recipe_foods.includes(:food).each do |recipe_food|
      key = recipe_food.food.name
      quantity = recipe_food.quantity
      hash[key] ? hash[key] += quantity : hash[key] = quantity
    end
    hash
  end
end
