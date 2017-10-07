class CreateMenuCategory < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_category do |t|
      t.integer :name
      t.integer :description
      t.integer :menu_id
    end
  end
end
