require 'bcrypt'
class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  has n, :peeps, :through => Resource
  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

  property :id, Serial
  property :name, String
  property :username, String, unique: true, :message => "This username is already taken"
  property :email, String, unique: true, :message => "This email is already taken"
  property :password_digest, Text


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(:username => username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end