class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words
  
  validates_presence_of :name
  validates_uniqueness_of :name

  scope :search, ->(name) { where("name LIKE ?", "%#{name}%") }

  def results
    lessons.map { |lesson| lesson.result || 0 }.inject :+
  end
end
