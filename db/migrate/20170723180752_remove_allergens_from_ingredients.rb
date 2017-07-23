class RemoveAllergensFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :allergens, :text
  end
end
