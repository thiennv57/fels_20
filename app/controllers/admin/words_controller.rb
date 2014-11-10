class Admin::WordsController < ApplicationController
  before_action :admin_auth
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id].blank?
      @words = Word.search(params[:content])
                   .paginate page: params[:page], per_page: 20
    else
      category = Category.find params[:category_id]
      @words = category.words.search(params[:content])
                       .paginate page: params[:page], per_page: 20
    end
  end

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_param
    if @word.save
      flash[:success] = "A new word has been added."
      redirect_to admin_words_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_param
      flash[:success] = "Update successfull."
      redirect_to admin_words_path
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy
    flash[:success] = "A word has been deleted."
    redirect_to admin_words_path
  end

  private

    def set_word
      @word = Word.find params[:id]
    end

    def word_param
      params.require(:word).permit(:content, :category_id)
    end
end
