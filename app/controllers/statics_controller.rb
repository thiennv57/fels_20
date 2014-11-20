class StaticsController < ApplicationController
  def home
    @lessons = current_user.lessons.paginate page: params[:page], per_page: 20
  end
end
