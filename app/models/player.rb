class Player < ApplicationRecord
  has_many :events
  belongs_to :team
end
