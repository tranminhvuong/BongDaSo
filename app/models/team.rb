class Team < ApplicationRecord
  acts_as_paranoid
  belongs_to :tournament
  has_many :players
  has_many :results
  has_many :ranks
  has_many :rounds, through: :ranks
  has_one_attached :logo
  has_many :matches, through: :results
end
