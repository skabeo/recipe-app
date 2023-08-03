class PublicRecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @public_recipes = Recipe.where(public: true).includes(:user, recipe_foods: :food).order(created_at: :desc)
    @food_counts = {}
    @total_prices = {}

    @public_recipes.each do |recipe|
      food_count = recipe.recipe_foods.select(:food_id).distinct.count
      @food_counts[recipe.id] = food_count

      total_price = recipe.recipe_foods.joins(:food).sum('foods.price * recipe_foods.quantity')
      @total_prices[recipe.id] = total_price
    end
  end
end
