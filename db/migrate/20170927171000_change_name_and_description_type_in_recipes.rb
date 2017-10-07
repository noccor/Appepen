class ChangeNameAndDescriptionTypeInRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :name, :text
    change_column :recipes, :description, :text
  end
end
