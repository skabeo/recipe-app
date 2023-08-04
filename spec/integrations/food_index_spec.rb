require 'rails_helper'
require 'faker'

RSpec.feature 'User recipe index', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')
    @user.skip_confirmation!
    @food = Food.create(name: 'Jollof', measurement_unit: 'pound',
                        price: 40, quantity: 3, user_id: @user.id)
  end

  scenario 'should display food name' do
    login_as(@user, scope: :user)

    visit foods_path
    expect(page).to have_content(@food.name)
  end

  scenario 'should display measurement unit' do
    login_as(@user, scope: :user)

    visit foods_path
    expect(page).to have_content(@food.measurement_unit)
  end

  scenario 'Can see food price' do
    login_as(@user, scope: :user)

    visit foods_path
    expect(page).to have_content(@food.price)
  end

  scenario 'Can see food quantity' do
    login_as(@user, scope: :user)

    visit foods_path
    expect(page).to have_content(@food.quantity)
  end

  scenario 'Can see add food button' do
    login_as(@user, scope: :user)

    visit foods_path
    expect(page).to have_content('Add food')
  end
end
