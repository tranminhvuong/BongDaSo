class Player < ApplicationRecord
  belongs_to :team, foreign_key: 'team_id'
  has_many :events
  has_one_attached :avatar
  has_one :tournament, through: :team
  acts_as_paranoid
  has_many :goals, -> { goals_for }, class_name: Event.name
  has_many :red_cards, -> { red_cards }, class_name: Event.name
  has_many :yellow_cards, -> { yellow_cards }, class_name: Event.name

  validates :name, presence: true, length: { maximum: 255 }
  validates :position, presence: true, length: { maximum: 50 }
  validates :number, presence: true 
end
