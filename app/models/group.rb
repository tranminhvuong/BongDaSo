class Group < ApplicationRecord
  belongs_to :tournament
  has_many :results
  has_many :matches
end
