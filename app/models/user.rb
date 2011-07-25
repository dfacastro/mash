require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :musics, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  
  before_create :generate_confirmation_code
  
  validates :username, :uniqueness => true
  validates :username, :name, :email, :presence => true
  
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  
  validate :password_must_be_present
  
  private
  def generate_confirmation_code
    self.confirmed = false
    self.confirmation_code = SecureRandom.base64(13)
  end
  
  def password_must_be_present
    errors.add(:password, "Missing Password") unless hashed_password.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  public
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'wibble' + salt)
  end

  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  def User.authenticate(username, password)
    if user = find_by_username(username)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end
  
  
  
end
