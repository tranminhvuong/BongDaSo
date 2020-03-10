class Player < ApplicationRecord
  has_many :events
  belongs_to :team
  belongs_to :position
  validates :name, presence: true
  validates :position_id, presence: true
  validates :address, presence: true
  validates :date_of_birth, presence: true
  acts_as_paranoid
end
