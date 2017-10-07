class RenameRecipiesToRecipes < ActiveRecord::Migration[5.1]
  def change
    rename_table :recipies, :recipes
  end
end
