class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      format.html { redirect_to @menu, notice: 'menu was successfully created.' }
      format.json { render :show, status: :created, location: @menu }
    else
      format.html { render :new }
      format.json { render json: @menu.errors, status: :unprocessable_entity }
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :type, :description)
  end
end
