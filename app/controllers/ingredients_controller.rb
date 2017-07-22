class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      format.html { redirect_to @ingredient, notice: 'ingredient was successfully created.' }
      format.json { render :show, status: :created, location: @ingredient }
    else
      format.html { render :new }
      format.json { render json: @ingredient.errors, status: :unprocessable_entity }
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :allergens, :type, :flavor)
  end
end
