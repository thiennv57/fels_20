class WordAnswer < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson_word
  
  validates_presence_of :content
end
