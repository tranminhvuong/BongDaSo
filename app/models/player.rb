class Player < ApplicationRecord
  belongs_to :team, foreign_key: 'team_id'
  validates :name, presence: true
  has_many :events
  has_one :tournament, through: :team
  acts_as_paranoid
  has_many :goals, -> { goals_for }, class_name: Event.name
end
