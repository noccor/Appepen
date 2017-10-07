class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to menu_path(MenuCategory.find(@meal.menu_category_id).menu_id), notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      redirect_to meal_path(@meal.id)
    else
      render 'edit'
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    menu_id = @meal.menu_category.menu_id
    @meal.destroy

    redirect_to menu_path(menu_id)
  end

  private

  def meal_params
    params.require(:meal).permit(:menu_category_id, :price, :name, :description, :ingredients, :traces_of_gluten, :traces_of_nuts, :traces_of_lactose)
  end
end
