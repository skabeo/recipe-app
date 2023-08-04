require 'rails_helper'
require 'faker'

RSpec.feature 'User recipe index', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')
    @user.skip_confirmation!
    @recipe = Recipe.create(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min',
                            description: 'Corn dough 30kg', public: true, user_id: @user.id)
    @food = Food.create(name: 'Jollof', measurement_unit: 'pound', price: 40, quantity: 3, user_id: @user.id)
    @recipe_food1 = RecipeFood.create(quantity: 10, recipe_id: @recipe.id, food_id: @food.id)
    @recipe_food2 = RecipeFood.create(quantity: 30, recipe_id: @recipe.id, food_id: @food.id)
  end

  scenario 'should display recipe food quantity' do
    login_as(@user, scope: :user)

    visit shopping_list_index_path(recipe_id: @recipe.id)
    expect(page).to have_content(@recipe_food1.quantity)
    expect(page).to have_content(@recipe_food2.quantity)
  end

  scenario 'should display recipe food price' do
    login_as(@user, scope: :user)

    visit shopping_list_index_path(recipe_id: @recipe.id)
    price = @food.price
    quantity = @recipe_food1.quantity
    total_price = price * quantity
    expect(page).to have_content(total_price)
  end
end
