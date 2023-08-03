require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Food, type: :model do
  describe 'Food model' do
    describe 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:recipe_foods).dependent(:destroy) }
      it { should have_many(:recipes).through(:recipe_foods) }
    end

    describe 'validations' do
      it 'validates presence of name' do
        food = Food.new(name: nil)
        expect(food).not_to be_valid
        expect(food.errors[:name]).to include("can't be blank")
      end

      it 'validates length of name' do
        food = Food.new(name: 'a' * 101)
        expect(food).not_to be_valid
        expect(food.errors[:name]).to include("is too long (maximum is 100 characters)")
      end

      it 'validates presence of measurement_unit' do
        food = Food.new(measurement_unit: nil)
        expect(food).not_to be_valid
        expect(food.errors[:measurement_unit]).to include("can't be blank")
      end

      it 'validates length of measurement_unit' do
        food = Food.new(measurement_unit: 'a' * 51)
        expect(food).not_to be_valid
        expect(food.errors[:measurement_unit]).to include("is too long (maximum is 50 characters)")
      end

      it 'validates presence of price' do
        food = Food.new(price: nil)
        expect(food).not_to be_valid
        expect(food.errors[:price]).to include("can't be blank")
      end

      it 'validates numericality of price' do
        food = Food.new(price: 'abc')
        expect(food).not_to be_valid
        expect(food.errors[:price]).to include("is not a number")
      end

      it 'validates price is greater than or equal to 0' do
        food = Food.new(price: -1)
        expect(food).not_to be_valid
        expect(food.errors[:price]).to include("must be greater than or equal to 0")
      end

      it 'validates presence of quantity' do
        food = Food.new(quantity: nil)
        expect(food).not_to be_valid
        expect(food.errors[:quantity]).to include("can't be blank")
      end

      it 'validates numericality of quantity' do
        food = Food.new(quantity: 'abc')
        expect(food).not_to be_valid
        expect(food.errors[:quantity]).to include("is not a number")
      end

      it 'validates quantity is greater than or equal to 0' do
        food = Food.new(quantity: -1)
        expect(food).not_to be_valid
        expect(food.errors[:quantity]).to include("must be greater than or equal to 0")
      end
    end
  end
end
