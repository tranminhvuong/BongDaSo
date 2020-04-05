class Result < ApplicationRecord
  belongs_to :match
  belongs_to :team
  has_many :events
  acts_as_paranoid
  
  validates :team_id, presence: true
  validates :match_id, presence: true
  validates :goals, presence: true, numericality: { greater_than_or_equal_to: 0}
end
