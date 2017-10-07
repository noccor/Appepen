class RenameRecipiesToRecipieIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_table :recipies, :recipie_ingredients
  end
end
