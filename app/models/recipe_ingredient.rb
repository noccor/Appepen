class RecipeIngredient < ActiveRecord::Base
  belongs_to :meal
  belongs_to :ingredients
  belongs_to :recipies

  validates :meal_id, presence: true

  validates :ingredient_id, presence: true

end
