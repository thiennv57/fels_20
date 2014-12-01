class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :lesson_words

  before_save :update_result

  def last_updated_at
    updated_at.strftime "%h %d, %Y"
  end

  private

    def update_result
      self.result = lesson_words.select do 
        |lesson_word| lesson_word.word_answer.try(:correct?)
      end.count
    end
end
