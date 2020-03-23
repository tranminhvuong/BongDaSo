class Tournament < ApplicationRecord
  acts_as_paranoid
  has_many :teams
  has_many :rounds
  has_many :ranks, through: :rounds
  has_many :matches, through: :rounds
end
