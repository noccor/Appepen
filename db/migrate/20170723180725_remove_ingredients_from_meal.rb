class RemoveIngredientsFromMeal < ActiveRecord::Migration[5.1]
  def change
    remove_column :meals, :ingredients, :string
  end
end
