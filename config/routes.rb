Rails.application.routes.draw do

  root 'application#index'

  resources :menus

  resources :meals do
    collection do
      get 'new/for_menu_category/:menu_category_id', action: :new,  as: :new_categoriseds
    end
  end

  resources :menu_categories do
    collection do
      get 'new/for_menu/:menu_id', action: :new, as: :new_menu_category
    end
  end

  resources :recipes, except: :new do
    collection do
      get 'new/for_meal/:meal_id', action: :new, as: :new_recipe
    end
  end

  resources :ingredients
  resources :recipe_ingredients

end
