class Team < ApplicationRecord
  acts_as_paranoid
  belongs_to :tournament
  has_many :players, dependent: :destroy
  has_many :results
  has_many :ranks,  dependent: :destroy
  has_many :rounds, through: :ranks
  has_one_attached :logo
  has_many :matches, through: :results
  has_many :red_cards, through: :players, source: 'red_cards'
end
