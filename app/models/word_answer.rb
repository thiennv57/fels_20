class WordAnswer < ActiveRecord::Base
  belongs_to :word, inverse_of: :word_answers
  has_many :lesson_words
  
  validates_presence_of :content, :word

  scope :corrected, -> { where("correct = true").first }
end
