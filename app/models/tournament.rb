class Tournament < ApplicationRecord
  acts_as_paranoid
  has_rich_text :description
  has_many :teams,  dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :ranks, through: :rounds
  has_many :matches, through: :rounds
  has_many :players, through: :teams
end
