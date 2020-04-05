class Rank < ApplicationRecord
  belongs_to :team
  belongs_to :round
  has_many :goals, through: :team, source: 'goals_for'

  validates :team_id, presence:true
  validates :round_id, presence: true
  validates :goals_for, presence: true
  validates :goals_against, presence: true
  validates :win, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :lose, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :draw, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
