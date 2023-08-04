require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq :has_many
    end

    it 'has many recipes' do
      association = described_class.reflect_on_association(:recipes)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'validates presence of email' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email (case-insensitive)' do
      User.create(email: 'test@example.com', password: 'password123')
      user2 = User.new(email: 'test@example.com', password: 'password456')
      user2.valid?
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'validates presence of password' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates length of password is at least 6 characters' do
      user = User.new(password: '12345')
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
