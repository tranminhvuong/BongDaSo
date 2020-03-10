class Position < ApplicationRecord
  has_many :players
  acts_as_paranoid
end
