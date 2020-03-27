class Match < ApplicationRecord
  has_many :results
  belongs_to :round
  has_many :teams, through: :results
  has_one :tournament, through: :round
  acts_as_paranoid

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
