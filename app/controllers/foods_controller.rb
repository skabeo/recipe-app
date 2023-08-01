class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      # redirect_to foods_path, notice: 'Food added succesfully'
      flash[:notice] = 'Food added successfully!'
      redirect_to foods_path
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, notice: 'Food was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end