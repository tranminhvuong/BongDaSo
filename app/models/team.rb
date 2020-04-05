class Team < ApplicationRecord
  acts_as_paranoid
  belongs_to :tournament
  has_rich_text :description
  has_many :players, dependent: :destroy
  has_many :results
  has_many :ranks,  dependent: :destroy
  has_many :rounds, through: :ranks
  has_one_attached :logo
  has_many :matches, through: :results
  has_many :red_cards, through: :players, source: 'red_cards'

  validates :name, presence: true, length: { maximum: 50 }
  validates :tournament_id, presence: true
  validate :name_cannot_exists_in_a_tournament, on: :update

  def name_cannot_exists_in_a_tournament
    a = Tournament.find(self.tournament_id).teams.find_by(name: self.name)
    if a.nil?
      p "ok"
    elsif a.id == self.id
      p "ok"
    else
      errors.add(:name, "can't be same as another team")
    end
  end
end
