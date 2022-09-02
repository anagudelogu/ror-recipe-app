class ShoppingListController < ApplicationController
  def index
    @inventory = current_user.inventory
    @ingredients = current_user.recipes.map(&:ingredients).reduce { |a, b| a.merge(b) { |_, m, n| m + n } } || {}
    @shopping_list = @ingredients.merge(@inventory.select { |k, _v| @ingredients.key?(k) }) do |_, c, d|
      { qt: c - d[:qt], price: d[:price] } if (c - d[:qt]).positive?
    end

    @shopping_list = @shopping_list.compact
  end
end
