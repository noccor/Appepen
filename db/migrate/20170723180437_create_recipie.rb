class CreateRecipie < ActiveRecord::Migration[5.1]
  def change
    create_table :recipies do |t|
      t.integer :menu_id
      t.integer :ingredient_id
      t.integer :quantity
      t.string :measure
    end
  end
end
