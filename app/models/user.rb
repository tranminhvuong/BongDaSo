class User < ApplicationRecord
  attr_accessor :remember_token
  has_one :role
  has_many :posts
  has_many :permissions, through: :role
  has_one :team
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  after_create :create_role

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

  def create_role
    Role.create(role: 'New User', user_id: self.id)
  end
end
