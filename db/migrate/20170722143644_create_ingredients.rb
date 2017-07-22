class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.text :allergens, default: [].to_yaml, array: true
      t.string :type
      t.string :flavor
    end
  end
end
