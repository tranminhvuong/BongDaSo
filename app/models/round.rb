class Round < ApplicationRecord
  belongs_to :round_detail
  belongs_to :tournament
  has_many :matches, dependent: :destroy
  has_many :ranks
  has_many :teams, through: :ranks

  validates :round_detail_id, presence: true
  validates :tournament_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :is_return, presence: true
end
