class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @new_recipe = current_user.recipes.new(recipe_params)
    if @new_recipe.save!
      redirect_to recipes_path, flash: { alert: 'Recipe added' }
    else
      redirect_to new_recipe_path, flash: { alert: 'Coud not save recipe' }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy!
    flash[:notice] = 'Recipe deleted'
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end
end
