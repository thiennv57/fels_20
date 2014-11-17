class CategoriesController < ApplicationController
  before_action :user_auth
  
  def index
    @categories = Category.all.paginate page: params[:page], per_page: 20
  end
end
