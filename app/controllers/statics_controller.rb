class StaticsController < ApplicationController
  def home
    if user_signed_in?
      @lessons = current_user.lessons.paginate page: params[:page], per_page: 20
    end
  end

  def about
  end

  def contact
  end
end
