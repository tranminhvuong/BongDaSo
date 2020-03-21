class Team < ApplicationRecord
  belongs_to :tournament
  has_many :players
  has_many :results
  has_many :ranks
  has_many :rounds, through: :ranks
  has_one_attached :logo
  acts_as_paranoid
end
