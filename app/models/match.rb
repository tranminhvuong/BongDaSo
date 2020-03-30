class Match < ApplicationRecord
  acts_as_paranoid
  has_many :results, dependent: :destroy
  belongs_to :round
  has_many :teams, through: :results
  has_one :tournament, through: :round

  scope :include_details, -> {
    includes(:teams, :results)
  }

  scope :by_tournament, ->(tour_id) {
    where(tournament_id: tour_id)
  }

  scope :order_by_time, ->(order) {
    order('time ?', order)
  }

  def update_winner_id
    results = self.results
    if results.first.goals == results.last.goals
      self.update_attributes(winner_id: 0)
    elsif results.first.goals > results.last.goals
      self.update_attributes(winner_id: results.first.id)
    else
      self.update_attributes(winner_id: results.last.id)
    end
  end
end
