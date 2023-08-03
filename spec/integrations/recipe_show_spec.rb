require 'rails_helper'
require 'faker'

RSpec.feature 'User recipe show', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')
    @user.skip_confirmation!
    @recipe = Recipe.create(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min', description: 'Corn dough 30kg',
                            user_id: @user.id)
  end

  scenario 'should display recipe name' do
    login_as(@user, scope: :user)

    visit recipe_path(@recipe.id)
    expect(page).to have_content(@recipe.name)
  end

  scenario 'should display recipe preparation time' do
    login_as(@user, scope: :user)

    visit recipe_path(@recipe.id)
    expect(page).to have_content(@recipe.preparation_time)
  end

  scenario 'should display recipe cooking time' do
    login_as(@user, scope: :user)

    visit recipe_path(@recipe.id)
    expect(page).to have_content(@recipe.cooking_time)
  end

  scenario 'Can see add ingredient button' do
    login_as(@user, scope: :user)

    visit recipe_path(@recipe.id)
    expect(page).to have_content('Generate shopping List')
  end
end
