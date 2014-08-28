class User < ActiveRecord::Base
  has_many :messages
  include BCrypt
#  validates :username,presence: true
#  validates :username,uniqueness: true
#  validates :password_hash,presence: true
# validates :email,presence: true
# validates :email,uniqueness: true
# validates :rating,presence: true

def password
    @password = Password.new(password_hash)

  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
end
