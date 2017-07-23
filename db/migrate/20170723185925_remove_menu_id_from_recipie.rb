class RemoveMenuIdFromRecipie < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipies, :menu_id, :integer
  end
end
