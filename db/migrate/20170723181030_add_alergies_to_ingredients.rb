class AddAlergiesToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :celery, :boolean
    add_column :ingredients, :cereal, :boolean
    add_column :ingredients, :crustacean, :boolean
    add_column :ingredients, :egg, :boolean
    add_column :ingredients, :fish, :boolean
    add_column :ingredients, :lupin, :boolean
    add_column :ingredients, :milk, :boolean
    add_column :ingredients, :mollusc, :boolean
    add_column :ingredients, :mustard, :boolean
    add_column :ingredients, :nut, :boolean
    add_column :ingredients, :peanut, :boolean
    add_column :ingredients, :sesame, :boolean
    add_column :ingredients, :soya, :boolean
    add_column :ingredients, :sulphites, :boolean
  end
end
