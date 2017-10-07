class MenuCategoriesController < ApplicationController
  def index
    @menu_categories = MenuCategory.all
  end

  def show
    @menu_category = MenuCategory.find(params[:id])
  end

  def new
    @menu_category = MenuCategory.new
  end

  def edit
    @menu_category = MenuCategory.find(params[:id])
  end

  def create
    @menu_category = MenuCategory.new(menu_category_params)

    respond_to do |format|
      if @menu_category.save
        format.html { redirect_to menu_path(@menu_category.menu_id), notice: 'MenuCategory was successfully created.' }
        format.json { render :show, status: :created, location: @menu_category}
      else
        format.html { render :new }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @menu_category = MenuCategory.find(params[:id])

    if @menu_category.update(menu_category_params)
      redirect_to menu_path(@menu_category.menu_id)
    else
      render 'edit'
    end
  end

  def destroy
    @menu_category = MenuCategory.find(params[:id])
    menu_id = @menu_category.menu_id
    @menu_category.meals.destroy_all
    @menu_category.destroy

    redirect_to menu_path(menu_id)
  end

  private

  def menu_category_params
    params.require(:menu_category).permit(:menu_id, :name, :description)
  end
end
