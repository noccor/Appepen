class RecipiesController < ApplicationController
  def index
    @recipies = Recipie.all
  end

  def show
    @recipie = Recipie.find(params[:id])
  end

  def new
    @recipie = Recipie.new
  end

  def edit
    @recipie = Recipie.find(params[:id])
  end

  def create
    @recipie = Recipie.new(recipie_params)

    respond_to do |format|
      if @recipie.save
        format.html { redirect_to @recipie, notice: 'Recipie was successfully created.' }
        format.json { render :show, status: :created, location: @recipie }
      else
        format.html { render :new }
        format.json { render json: @recipie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipie = Recipie.find(params[:id])

    if @recipie.update(recipie_params)
      redirect_to @recipie
    else
      render 'edit'
    end
  end

  def destroy
    @recipie = Recipie.find(params[:id])
    @recipie.destroy

    redirect_to recipies_path
  end

  private

  def recipie_params
    params.require(:recipie).permit(:menu_id, :ingredient_id, :modify, :quantity, :measure)
  end
end
