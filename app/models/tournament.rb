class Tournament < ApplicationRecord
  acts_as_paranoid
  has_rich_text :description
  has_many :teams,  dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :ranks, through: :rounds
  has_many :matches, through: :rounds
  has_many :players, through: :teams

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
