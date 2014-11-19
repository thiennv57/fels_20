class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :lesson_words

  before_save :update_result

  private

    def update_result
      self.result = lesson_words.select do 
        |lesson_word| lesson_word.word_answer.try(:correct?)
      end.count
    end
end
