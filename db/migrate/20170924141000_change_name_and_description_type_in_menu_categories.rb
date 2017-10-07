class ChangeNameAndDescriptionTypeInMenuCategories < ActiveRecord::Migration[5.1]
  def change
    change_column :menu_categories, :name, :text
    change_column :menu_categories, :description, :text
  end
end
