class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.integer :menu_id
      t.string :name
      t.string :description
      t.text :ingredients, default: [].to_yaml, array: true
      t.boolean :traces_of_nuts
      t.boolean :traces_of_gluten
      t.boolean :traces_of_lactose
    end
  end
end
