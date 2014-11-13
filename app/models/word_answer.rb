class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :lesson_words
  
  validates_presence_of :content, :word_id

  scope :corrected, -> { where("correct = true").first }
end
