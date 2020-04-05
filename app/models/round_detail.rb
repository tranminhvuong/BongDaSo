class RoundDetail < ApplicationRecord
  has_many :rounds

  validates :name, presence: true, length: { maximum: 50 }
  validates :round_type, presence: true, length: { maximum: 50 }
  validates :num_of_teams, presence: true, numericality: { greater_than_or_equals_to: 2 }
end
