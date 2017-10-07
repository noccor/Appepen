class RenameMenuCategoryToMenuCategories < ActiveRecord::Migration[5.1]
  def change
    rename_table :menu_category, :menu_categories
  end
end
