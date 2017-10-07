class Recipe < ActiveRecord::Base
  belongs_to :meal

  has_many :recipe_ingredients

  validates :meal_id, presence: true

end
