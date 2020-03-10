class Team < ApplicationRecord
  has_one_attached :logo
  has_many :players
  has_many :results
  belongs_to :tournament
  has_many :groups, through: :results
  acts_as_paranoid
end
