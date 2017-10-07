class ChangeMealIdToRecipeIdInRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipe_ingredients, :meal_id, :recipe_id
  end
end
