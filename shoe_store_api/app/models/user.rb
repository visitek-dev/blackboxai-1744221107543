class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :admin, inclusion: { in: [true, false] }

  before_validation :set_default_admin, on: :create

  def generate_jwt
    payload = { 
      user_id: id,
      exp: Rails.application.config.jwt_expiration.seconds.from_now.to_i
    }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, Rails.application.config.jwt_algorithm)
  end

  private

  def set_default_admin
    self.admin ||= false
  end
end
