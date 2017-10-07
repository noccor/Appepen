class RecipeIngredientsController < ApplicationController
  def index
    @recipe_ingredient_ingredients = Recipe.all
  end

  def show
    @recipe_ingredient = Recipe.find(params[:id])
  end

  def new
    @recipe_ingredient = Recipe.new
  end

  def edit
    @recipe_ingredient = Recipe.find(params[:id])
  end

  def create
    @recipe_ingredient = Recipe.new(recipe_ingredient_params)

    respond_to do |format|
      if @recipe_ingredient.save
        format.html { redirect_to @recipe_ingredient, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_ingredient }
      else
        format.html { render :new }
        format.json { render json: @recipe_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipe_ingredient = Recipe.find(params[:id])

    if @recipe_ingredient.update(recipe_ingredient_params)
      redirect_to @recipe_ingredient
    else
      render 'edit'
    end
  end

  def destroy
    @recipe_ingredient = Recipe.find(params[:id])
    @recipe_ingredient.destroy

    redirect_to recipe_ingredient_ingredients_path
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:meal_id, :ingredient_id, :modify, :quantity, :measure)
  end
end
