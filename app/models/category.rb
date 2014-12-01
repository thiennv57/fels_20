class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name

  scope :search, ->(name) { where "name LIKE ?", "%#{name}%" }

  def results
    lessons.map(&:result).inject(:+) || 0
  end
end
