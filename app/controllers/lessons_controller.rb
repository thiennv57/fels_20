class LessonsController < ApplicationController
  before_action :user_auth

  def index
    @lessons = current_user.lessons
  end

  def create
    category = Category.find params[:lesson][:category_id]
    @lesson = category.lessons.create user_id: current_user.id
    generate_lesson_words @lesson # => generate 20 unique word answers
    redirect_to @lesson
  end

  def show
    @lesson = Lesson.find params[:id]
  end

  def update
    lesson = Lesson.find params[:id]
    if lesson.update_attributes(lesson_param)
      flash[:success] = "Congratulations you have successfully completed the lesson"
      redirect_to categories_path
    else
      flash[:error] = "An error has occurred"
      render "show"
    end
  end

  private

    def lesson_param
      params.require(:lesson).permit(:user_id, :category_id,
                    lesson_words_attributes: [:word_answer_id, :id])
    end

    def generate_lesson_words(lesson)
      @unique_word = lesson.category.words.order("RAND()").limit 20

      @unique_word.each do |word|
        lesson.lesson_words.create word_id: word.id, user_id: current_user.id
      end
    end
end
