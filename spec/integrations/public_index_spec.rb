require 'rails_helper'
require 'faker'

RSpec.feature 'User recipe index', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')
    @user.skip_confirmation!
    @recipe = Recipe.create(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min', description: 'Corn dough 30kg', public: true, user_id: @user.id)
  end

  scenario 'should display recipe name' do
    login_as(@user, scope: :user)

    visit public_recipes_path
    expect(page).to have_content(@recipe.name)
  end

  scenario 'should display recipe owner' do
    login_as(@user, scope: :user)

    visit public_recipes_path
    expect(page).to have_content(@recipe.user.name)
  end

  scenario 'should display food types' do
    login_as(@user, scope: :user)

    visit public_recipes_path
    @recipe.recipe_foods.each do |recipe_food|
      items = recipe_food.food.count
      expect(page).to have_content(items)
    end
  end

  scenario 'should display total price' do
    login_as(@user, scope: :user)

    visit public_recipes_path
    @recipe.recipe_foods.each do |recipe_food|
      quantity = recipe_food.quantity
      price = recipe_food.food.price
      total_price = quantity * price
      expect(page).to have_content(total_price)
    end
  end
end
