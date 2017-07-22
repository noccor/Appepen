class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      format.html { redirect_to @meal, notice: 'meal was successfully created.' }
      format.json { render :show, status: :created, location: @meal }
    else
      format.html { render :new }
      format.json { render json: @meal.errors, status: :unprocessable_entity }
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:menu_id, :name, :description, :ingredients, :traces_of_gluten, :traces_of_nuts, :traces_of_lactose)
  end
end
