class Tournament < ApplicationRecord
  acts_as_paranoid
  has_rich_text :description
  has_many :teams,  dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :ranks, through: :rounds
  has_many :matches, through: :rounds
  has_many :players, through: :teams

  validates :name, presence: true, length: { maximum: 50 }
  validates :formula, presence: true, inclusion: { in: 1..2}
  validates :time_start, presence: true
  validates :time_end, presence: true
  validate :time_end_cannot_less_than_time_start

  def time_end_cannot_less_than_time_start
    if time_start >= time_end
      errors.add(:time_end, "cannot greater than time_start")
    end
  end
  scope :finish, ->(str){
    now = Time.zone.now
    if str == 'done'
      where("time_end < ?", now)
    elsif str == 'all'
      all
    else
      where("time_end > ?", now)
    end
  }
end
