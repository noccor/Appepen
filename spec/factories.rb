FactoryGirl.define do
  factory :menu do
    name "name"
    description "description"
    cat "cat"
  end

  factory :meal do
    menu_id 1
    name "Banana Nut"
    description "Bananas and nuts"
    traces_of_nuts true
    traces_of_gluten false
    traces_of_lactose false
  end

  factory :ingredient do
    name "bread"
    description "bread"
    cat "staple"
    flavor "savory"
  end

  factory :recipie do
    meal_id 1
    ingredient_id 1
    modify true
    quantity 100
    measure "grams"
  end
end
