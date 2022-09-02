class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :foods
  has_many :recipes

  validates :name, presence: true

  def inventory
    hash = {}
    foods.each do |food|
      key = food.name
      quantity = food.quantity
      hash[key] ? hash[key][:qt] += quantity : hash[key] = { qt: quantity, price: food.price }
    end
    hash
  end
end
