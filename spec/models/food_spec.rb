require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many recipe_foods' do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many recipes through recipe_foods' do
      association = described_class.reflect_on_association(:recipes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:recipe_foods)
    end
  end

  describe 'validations' do
    it 'requires a name' do
      food = described_class.new(name: nil)
      expect(food).not_to be_valid
      expect(food.errors[:name]).to include("can't be blank")
    end

    it 'limits the length of name to 100 characters' do
      food = described_class.new(name: 'a' * 101)
      expect(food).not_to be_valid
      expect(food.errors[:name]).to include('is too long (maximum is 100 characters)')
    end

    it 'requires a measurement_unit' do
      food = described_class.new(measurement_unit: nil)
      expect(food).not_to be_valid
      expect(food.errors[:measurement_unit]).to include("can't be blank")
    end

    it 'limits the length of measurement_unit to 50 characters' do
      food = described_class.new(measurement_unit: 'a' * 51)
      expect(food).not_to be_valid
      expect(food.errors[:measurement_unit]).to include('is too long (maximum is 50 characters)')
    end

    it 'requires a price' do
      food = described_class.new(price: nil)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include("can't be blank")
    end

    it 'validates numericality of price' do
      food = described_class.new(price: 'abc')
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include('is not a number')
    end

    it 'requires price to be greater than or equal to 0' do
      food = described_class.new(price: -1)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include('must be greater than or equal to 0')
    end

    it 'requires a quantity' do
      food = described_class.new(quantity: nil)
      expect(food).not_to be_valid
      expect(food.errors[:quantity]).to include("can't be blank")
    end

    it 'validates numericality of quantity' do
      food = described_class.new(quantity: 'abc')
      expect(food).not_to be_valid
      expect(food.errors[:quantity]).to include('is not a number')
    end

    it 'requires quantity to be greater than or equal to 0' do
      food = described_class.new(quantity: -1)
      expect(food).not_to be_valid
      expect(food.errors[:quantity]).to include('must be greater than or equal to 0')
    end
  end
end
