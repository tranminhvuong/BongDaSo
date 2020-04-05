class Event < ApplicationRecord
  SCORED = 1.freeze
  GET_YELLOW_CARD = 2.freeze
  GET_RED_CARD = 3.freeze

  belongs_to :player
  belongs_to :result
  belongs_to :event_detail
  validates :event_detail_id, presence: true
  acts_as_paranoid

  scope :goals_for, -> {
    where(event_detail_id: SCORED)
  }

  # scope :goals_againist, -> {
  #   where(event_detail_id: SCORED)
  # }

  scope :red_cards, -> {
    where(event_detail_id: GET_RED_CARD)
  }

  scope :yellow_cards, -> {
    where(event_detail_id: GET_YELLOW_CARD)
  }
end
