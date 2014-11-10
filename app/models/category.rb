class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  
  validates_presence_of :name
end
