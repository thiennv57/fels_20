class Word < ActiveRecord::Base
  has_one :lesson_word
  belongs_to :category
  has_many :word_answers
  
  validates_presence_of :content, :category_id

  scope :learned, ->(user_id, category_id) do
    lesson_word_ids = LessonWord.select("word_id")
          .where("user_id = ? AND word_answer_id IS NOT NULL", user_id).to_sql
    if category_id
      Word.where "id IN (#{lesson_word_ids}) and category_id = ?", category_id
    else
      Word.where "id IN (#{lesson_word_ids})"
    end
  end

  scope :not_learned, ->(user_id, category_id) do
    lesson_word_ids = LessonWord.select("word_id")
      .where("user_id = ? and word_answer_id IS NULL", user_id).to_sql
    if category_id
      Word.where "id IN (#{lesson_word_ids}) and category_id = 1", category_id
    else
      Word.where "id IN (#{lesson_word_ids})"
    end
  end
end
