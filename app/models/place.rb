class Place < ApplicationRecord
  has_many :matches
  acts_as_paranoid
end
