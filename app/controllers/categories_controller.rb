class CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_param
    if @category.save
      flash[:success] = "A new category has been added."
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_param
      flash[:success] = "Update successfull."
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "A category has been deleted."
    redirect_to categories_path
  end

  private

    def set_category
      @category = Category.find params[:id]
    end
    
    def category_param
      params.require(:category).permit(:name)
    end
end
