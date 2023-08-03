require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Recipe model' do
    user = User.create(name: 'spencer', email: 'test@gmail.com', password: '123456')
    subject do
      Recipe.new(name: 'banku', preparation_time: '1 hour', cooking_time: '30 min', description: 'Corn dough 30kg',
                 user_id: user.id)
    end
    before { subject.save }

    it 'name should not be blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'check name limit' do
      subject.name = 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem
      ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem
      ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum'
      expect(subject).to_not be_valid
    end

    it 'prepration_time should not be blank' do
      subject.preparation_time = nil
      expect(subject).to_not be_valid
    end

    it 'preparation character limit' do
      subject.preparation_time = 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum'
      expect(subject).to_not be_valid
    end

    it 'cooking_time is not blank' do
      subject.cooking_time = nil
      expect(subject).to_not be_valid
    end

    it 'cooking_time character limit' do
      subject.cooking_time = 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum'
      expect(subject).to_not be_valid
    end

    it 'description is not blank' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'description character limit' do
      subject.description = 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum
      Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum'
      expect(subject).to_not be_valid
    end
  end
end
