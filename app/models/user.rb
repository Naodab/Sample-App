class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d]+(-[a-z\d]+)*\.)+[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*[A-Za-z])(?=.*\d).+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  validates :password,
            presence: true,
            length: { minimum: 6 },
            format: { with: VALID_PASSWORD_REGEX }

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
