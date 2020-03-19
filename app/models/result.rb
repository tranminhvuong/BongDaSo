class Result < ApplicationRecord
  belongs_to :match
  belongs_to :team
  has_many :events
  acts_as_paranoid
end
