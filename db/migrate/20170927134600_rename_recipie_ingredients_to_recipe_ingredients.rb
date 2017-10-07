class RenameRecipieIngredientsToRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_table :recipie_ingredients, :recipe_ingredients
  end
end
