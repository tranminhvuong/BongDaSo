class Tournament < ApplicationRecord
  has_many :teams
  has_many :rounds
  acts_as_paranoid
end
