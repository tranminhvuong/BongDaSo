class Match < ApplicationRecord
  has_many :results
  belongs_to :round
  has_many :teams, through: :results
  has_one :tournament, through: :round
  acts_as_paranoid
end
