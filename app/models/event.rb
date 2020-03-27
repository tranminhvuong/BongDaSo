class Event < ApplicationRecord
  SCORED = 1.freeze
  GET_YELLOW_CARD = 2.freeze
  GET_RED_CARD = 3.freeze

  belongs_to :player
  belongs_to :result
  belongs_to :event_detail
  acts_as_paranoid

  after_create :increment_result_count
  after_destroy :decrement_result_count

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

  def increment_result_count
    result = self.result
    result.increment!(:goals) if self.event_detail_id == SCORED
    match = result.match
    match.update_winner_id if match.winner_id != result.id
  end

  def decrement_result_count
    result = self.result
    result.decrement!(:goals) if self.event_detail_id == SCORED
    match = result.match
    match.update_winner_id if match.winner_id == result.id
  end
end
