class User < ApplicationRecord
  attr_accessor :remember_token
  belongs_to :role
  has_many :posts
  has_one :team
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  acts_as_paranoid

  # Returns the hash digest of the given string.
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
