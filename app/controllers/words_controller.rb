class WordsController < ApplicationController
  before_action :user_auth

  def index
    if params[:learn] == "all" || params[:learn].blank?
      if params[:category_id].blank?
        @words = Word.all.paginate page: params[:page], per_page: 20
      else
        category = Category.find params[:category_id]
        @words = category.words.paginate page: params[:page], per_page: 20
      end
    elsif params[:learn] == "learned"
      @words = Word.learned(current_user.id, params[:category_id])
              .paginate page: params[:page], per_page: 20
    else
      @words = Word.not_learned(current_user.id, params[:category_id])
              .paginate page: params[:page], per_page: 20
    end
  end
end
