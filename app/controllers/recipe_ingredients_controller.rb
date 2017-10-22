class RecipeIngredientsController < ApplicationController


  def index
    @recipe_ingredient_ingredients = RecipeIngredient.all
  end

  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def edit
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def create

    params = recipe_ingredient_params
    if Ingredient.where(id: params[:ingredient_id]).empty?
      new_ingredient = Ingredient.new(name: params[:ingredient_id], description: 'description', celery: params['celery'], cereal: params['cereal'], crustacean: params['crustacean'], egg: params['egg'],fish: params['fish'],lupin: params['lupin'],milk: params['milk'],mollusc: params['mollusc'],
      mustard: params['mustard'], nut: params['nut'],peanut: params['peanut'],sesame: params['sesame'],soya: params['soya'],sulphites: params['sulphites'])
      new_ingredient.save
      require 'pry'; binding.pry

      params['ingredient_id'] = Ingredient.where(name: params[:ingredient_id]).first.id
    end

    @recipe_ingredient = RecipeIngredient.new(params.except(:celery, :cereal, :crustacean, :egg, :fish, :lupin, :milk, :mollusc, :mustard, :nut, :peanut, :sesame, :soya, :sulphites))
    @recipe = Recipe.find(params[:recipe_id])

    respond_to do |format|
      if @recipe_ingredient.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
      else
        format.html { redirect_to @recipe, notice: @recipe_ingredient.errors }
      end
    end
  end

  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])

    if @recipe_ingredient.update(recipe_ingredient_params)
      redirect_to @recipe_ingredient
    else
      render 'edit'
    end
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy

    redirect_to recipe_ingredient_path
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :modify, :quantity, :measure, :celery, :cereal, :crustacean, :egg, :fish, :lupin, :milk, :mollusc, :mustard, :nut, :peanut, :sesame, :soya, :sulphites)
  end
end
