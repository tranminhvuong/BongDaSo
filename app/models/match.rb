class Match < ApplicationRecord
  acts_as_paranoid
  has_many :results, dependent: :destroy
  belongs_to :round
  has_many :teams, through: :results
  has_one :tournament, through: :round

  validates :turn, presence: true
  validates :place, presence: true, length: { maximum: 255 }
  validates :time, presence: true
  validates :round_id, presence: true

  scope :include_details, -> {
    includes(results: :team)
  }

  scope :by_tournament, ->(tour_id) {
    where(tournament_id: tour_id)
  }

  scope :order_by_time, ->(order) {
    order('time ?', order)
  }

  scope :status_match, ->(str){
    now = Time.zone.now
    if str == 'finish'
      where('time < ?', now)
    elsif str == 'not finish'
      where('time > ?', now)
    else
      all
    end
  }
end
