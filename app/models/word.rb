class Word < ActiveRecord::Base
  has_one :lesson_word
  belongs_to :category
  has_many :word_answers
  
  validates_presence_of :content, :category_id
end
