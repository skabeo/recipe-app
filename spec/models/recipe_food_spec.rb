require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'RecipeFood model do' do
    user = User.create(name: 'spencer', email: 'test@gmail.com', password: '123456')

    recipe = Recipe.new(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min',
                        description: 'Corn dough 30kg', user_id: user.id)

    food = Food.new(name: 'Banku', measurement_unit: 'pounds', price: 5)
    subject { RecipeFood.new(quantity: 25, recipe_id: recipe.id, food_id: food.id) }

    it 'quantity should not be blank' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it 'quantity should be an integer' do
      subject.quantity = true
      expect(subject).to_not be_valid
    end

    it 'quantity should be greater than 1' do
      expect(subject.quantity).to be >= 1
    end
  end
end
