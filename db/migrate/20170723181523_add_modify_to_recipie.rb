class AddModifyToRecipie < ActiveRecord::Migration[5.1]
  def change
    add_column :recipies, :modify, :boolean
  end
end
