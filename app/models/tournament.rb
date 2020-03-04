class Tournament < ApplicationRecord
  has_many :teams
  has_many :groups
end
