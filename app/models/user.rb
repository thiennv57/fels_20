class User < ActiveRecord::Base
  attr_accessor :remember_token, :password_not_require

  has_many :lessons, dependent: :destroy
  has_many :lesson_words, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader
  
  before_save -> { self.email.downcase! }
  
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: /[^@\s]+@[\w\-_\.]+\.\w{2,4}/i
  validates_length_of :password, minimum: 6, unless: :password_not_require
  
  has_secure_password

  scope :search, ->(name) { where("username LIKE ?", "%#{name}%") }

  def self.digest(string)
    BCrypt::Password.create string
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    self.password_not_require = true
    update_attributes! remember_digest: User.digest(remember_token)
    self.password_not_require = false
  end

  def forget
    self.password_not_require = true
    update_attributes! remember_digest: nil
    self.password_not_require = false
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def signed_up_at
    created_at.strftime "%h %d, %Y %l:%M %p"
  end
  
  def last_updated_at
    updated_at.strftime "%h %d, %Y %l:%M %p"
  end
end
