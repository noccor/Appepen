FactoryGirl.define do
  factory :menu do
    name "name"
    description "description"
    cat "cat"
  end

  factory :menu_category do
    id 1
    name "Starter"
    description "Start with this"
    menu_id 1
  end

  factory :meal do
    menu_id 1
    menu_category_id 1
    name "Banana Nut"
    description "Bananas and nuts"
    traces_of_nuts true
    traces_of_gluten false
    traces_of_lactose false
    price 1.99
  end

  factory :ingredient do
    name "bread"
    description "bread"
    cat "staple"
    flavor "savory"
  end

  factory :recipe do
    name "Somethingforthekids"
    description "yummy"
    organization_id 1
    meal_id 1
  end

  factory :recipe_ingredient do
    ingredient_id 1
    recipe_id 1
    modify true
    quantity 1
    measure 100
  end
end
