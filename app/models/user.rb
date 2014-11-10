class User < ActiveRecord::Base
  has_many :lessons
  
  mount_uploader :avatar, AvatarUploader
  
  before_save -> { self.email.downcase! }
  
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: /[^@\s]+@[\w\-_\.]+\.\w{2,4}/i
  
  has_secure_password
  
  def signed_up_at
    created_at.strftime "%h %d, %Y %l:%M %p"
  end
  
  def last_updated_at
    updated_at.strftime "%h %d, %Y %l:%M %p"
  end
end
