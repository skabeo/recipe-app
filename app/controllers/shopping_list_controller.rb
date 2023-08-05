class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:recipe_id]
      @recipe = Recipe.includes(recipe_foods: %i[food recipe]).find(params[:recipe_id])
      @shopping_list = calculate_shopping_list(@recipe)
    else
      @shopping_list = []
    end
  end

  private

  def calculate_shopping_list(recipe)
    shopping_list = []

    recipe.recipe_foods.each do |recipe_food|
      ingredient = recipe_food.food
      price = ingredient.price
      shopping_list << {
        ingredient: ingredient.name,
        quantity: recipe_food.quantity,
        price:
      }
    end

    shopping_list
  end
end
