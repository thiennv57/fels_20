class Word < ActiveRecord::Base
  has_one :lesson_word
  belongs_to :category
  has_many :word_answers, inverse_of: :word, dependent: :destroy
  accepts_nested_attributes_for :word_answers
  
  validates_presence_of :content, :category_id

  scope :learned, ->(user_id, category_id) do
    lesson_word_ids = LessonWord.select("word_id")
        .where("user_id = ? AND word_answer_id IS NOT NULL", user_id).to_sql
    unless category_id.blank?
      Word.where "id IN (#{lesson_word_ids}) AND category_id = ?", category_id
    else
      Word.where "id IN (#{lesson_word_ids})"
    end
  end

  scope :not_learned, ->(user_id, category_id) do
    lesson_word_ids = LessonWord.select("word_id")
      .where("user_id = ? AND word_answer_id IS NULL", user_id).to_sql
    unless category_id.blank?
      Word.where "id IN (#{lesson_word_ids}) AND category_id = ?", category_id
    else
      Word.where "id IN (#{lesson_word_ids})"
    end
  end

  scope :search, ->(content) do
    where("content LIKE ?", "%#{content}%")
  end

  scope :unique, ->(user, category) do
    used_word_ids = LessonWord.select(:word_id)
                              .where("user_id = ? AND category_id = ?",
                                      user.id, category.id)
                              .to_sql
    where "id NOT IN (#{used_word_ids}) AND category_id = ?", category.id
  end
end
