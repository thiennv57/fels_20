class WordsController < ApplicationController
  before_action :set_word, only: [:edit, :update, :destroy]
  before_action :admin_auth, except: [:index, :search]
  before_action :user_auth

  def index
    if params[:learn] == "all"
      if params[:category_id].blank?
        @words = Word.all.paginate page: params[:page], per_page: 20
      else
        category = category.find params[:id]
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

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_param
    if @word.save
      flash[:success] = "A new word has been added."
      redirect_to words_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_param
      flash[:success] = "Update successfull."
      redirect_to words_path
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy
    flash[:success] = "A word has been deleted."
    redirect_to words_path
  end

  private

    def set_word
      @word = Word.find params[:id]
    end

    def word_param
      params.require(:word).permit(:content, :category_id)
    end
end