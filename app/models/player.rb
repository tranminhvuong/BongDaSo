class Player < ApplicationRecord
  belongs_to :team, foreign_key: 'team_id'
  validates :name, presence: true
  has_many :events
  acts_as_paranoid
end
