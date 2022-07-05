class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  validates_uniqueness_of :email, case_sensitive: false, presence: true
  validates :password, length: { minimum: 4 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password_confirmation, presence: true


  def self.authenticate_with_credentials(email, password)
    
    user = User.find_by_email(email.downcase.strip)
    user && user.authenticate(password) ? user : nil
  end

end