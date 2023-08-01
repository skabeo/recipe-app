class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :food, through: :recipe_foods

  validates :name, presence: true, length: { in: 1..50 }
  validates :preparation_time, presence: true, length: { in: 1..100 }
  validates :cooking_time, presence: true, length: { in: 1..100 }
  validates :description, presence: true, length: { in: 1..300 }
end
