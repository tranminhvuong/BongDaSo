class Rank < ApplicationRecord
  belongs_to :team
  belongs_to :round
  has_many :goals, through: :team, source: 'goals_for'
end
