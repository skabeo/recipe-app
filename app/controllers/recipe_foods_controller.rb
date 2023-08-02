class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe_id = params[:recipe_id]
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.create(recipe_food_params)
    if @recipe_food.save
      flash[:notice] = 'Food saved'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash[:notice] = 'Food not saved'
      redirect_to new_recipe_recipe_food_path
    end
  end

  def edit
    @recipe_id = params[:recipe_id]
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy!
    flash[:notice] = 'Ingredient deleted'
    redirect_to recipe_path(params[:recipe_id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.update(edit_recipe_food_params)
    flash[:notice] = 'Ingredient updated'
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end

  def edit_recipe_food_params
    params.require(:edit_recipe_food).permit(:quantity, :food_id)
  end
end
