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
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    @recipe = Recipe.find(recipe_ingredient_params[:recipe_id])

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
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :modify, :quantity, :measure)
  end
end
