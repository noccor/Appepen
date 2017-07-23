class AddVeganVeggieToMeal < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :vegitarian, :boolean
    add_column :meals, :vegan, :boolean
  end
end
