class Match < ApplicationRecord
  has_many :results
  belongs_to :round
  acts_as_paranoid
end
