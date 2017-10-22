class RecipeIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe

  validates :recipe_id, presence: true

  validates :ingredient_id, presence: true

end
