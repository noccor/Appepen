class CreateRecipies < ActiveRecord::Migration[5.1]
  def change
    create_table :recipies do |t|
      t.integer :name
      t.integer :description
      t.integer :organization_id
      t.integer :meal_id
    end
  end
end
