class User < ActiveRecord::Base
  before_save :generate_token

  has_secure_password
  has_secure_token
  
  # Validations
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
              on: %i[create update]
            }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true
  
  # Callback to generate a new token
  def generate_token
    self.token = Libraries::JsonWebToken.encode(self.username, 5.hours.from_now)
  end
end