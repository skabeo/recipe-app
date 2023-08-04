class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
  end

  def create
    @new_recipe = current_user.recipes.new(recipe_params)
    if @new_recipe.save
      flash[:notice] = 'Recipe added'
      redirect_to recipes_path
    else
      flash[:alert] = 'Kindly fill all fields'
      redirect_to new_recipe_path
    end
  end

  def update
    if current_user
      @recipe = Recipe.find(params[:id])
      if @recipe.public
        @recipe.update(public: false)
        flash[:notice] = 'Recipe is private'
      else
        @recipe.update(public: true)
        flash[:notice] = 'Recipe is public'
      end
      redirect_to recipes_path
    else
      flash[:alert] = "Sorry you can't update recipe status"
      redirect_to recipe_path(param[:id])
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
