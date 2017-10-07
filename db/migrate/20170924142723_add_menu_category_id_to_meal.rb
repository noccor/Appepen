class AddMenuCategoryIdToMeal < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :menu_category_id, :integer
  end
end
