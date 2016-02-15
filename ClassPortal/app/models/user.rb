class User < ActiveRecord::Base
  has_secure_password

=begin
  attr_accessor :password


  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :presence =>true, :length => {:maximum => 50}
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true, :presence =>true
  validates_length_of :password, :in => 6..20, :on => :create


  before_save :encrypt_password
  after_save :clear_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.encrypted_password = nil
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
=end
end
