require 'rails_helper'
require 'faker'

RSpec.feature 'User recipe index', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')
    @user.skip_confirmation!
    @recipe = Recipe.create(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min',
                            description: 'Corn dough 30kg', user_id: @user.id)
  end

  scenario 'should display recipe name' do
    login_as(@user, scope: :user)

    visit recipes_path
    expect(page).to have_content(@recipe.name)
  end

  scenario 'should display recipe description' do
    login_as(@user, scope: :user)

    visit recipes_path
    expect(page).to have_content(@recipe.description)
  end

  scenario 'Can see Add a recipe button' do
    login_as(@user, scope: :user)

    visit recipes_path
    expect(page).to have_button(text: 'Add a recipe')
  end
end
